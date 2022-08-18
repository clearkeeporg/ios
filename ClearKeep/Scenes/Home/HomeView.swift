//
//  HomeView.swift
//  iOSBase-SwiftUI
//
//  Created by NamNH on 15/02/2022.
//

import SwiftUI
import Combine
import Common
import CommonUI
import Model
import Networking

private enum Constants {
	static let padding = 20.0
	static let paddingTop = 49.0
	static let opacity = 0.72
	static let blur = 10.0
	static let duration = 0.2
	static let spacing = 18.0
	static let paddingMenu = 34.0
}

struct HomeView: View {
	// MARK: - Variables
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.injected) private var injected: DIContainer
	@State private var selectedGroupId: Int64 = 0
	@State private var showMessageBanner: Bool = false
	@State private var messageData: MessagerBannerViewModifier.MessageData?
	@State private(set) var isExpandGroup: Bool = false
	@State private(set) var isExpandDirectMessage: Bool = false
	@State private var isFirstShowGroup: Bool = false
	@State private var isFirstShowPeer: Bool = false
	@State private var navigateToChat: Bool = false
	@State private var navigateToLogin: Bool = false
	@State private(set) var customServer: CustomServer = CustomServer()
	@State private var serverURL: String = ""
	@State private(set) var loadable: Loadable<HomeViewModels> = .notRequested {
		didSet {
			switch loadable {
			case .loaded(let load):
				isLoading = false
				let groups = load.groupViewModel?.viewModelGroup.filter { $0.groupType == "group" }.sorted(by: { $0.updatedAt > $1.updatedAt }).compactMap { profile in
					GroupViewModel(profile)} ?? []
				let peers = load.groupViewModel?.viewModelGroup.filter { $0.groupType != "group" }.sorted(by: { $0.updatedAt > $1.updatedAt }).compactMap { profile in
					GroupViewModel(profile)} ?? []
				if !groups.isEmpty && !isFirstShowGroup {
					isFirstShowGroup = true
					isExpandGroup = true
				}

				if !peers.isEmpty && !isFirstShowPeer {
					isFirstShowPeer = true
					isExpandDirectMessage = true
				}
				
				self.groups = groups
				self.peers = peers
				self.user = [UserViewModel(load.userViewModel?.viewModelUser)]
			case .failed(let error):
				isLoading = false
				self.error = HomeErrorView(error)
				self.isShowError = true
			case .isLoading:
				isLoading = true
			default: break
			}
		}
	}
	
	@State private var loadableStatus: Loadable<UserViewModels> = .notRequested {
		didSet {
			switch loadableStatus {
			case .loaded(let load):
				isLoading = false
				self.user = [UserViewModel(load.viewModelUser)]
			case .failed(let error):
				isLoading = false
				self.error = HomeErrorView(error)
				self.isShowError = true
			case .isLoading:
				isLoading = true
			default: break
			}
		}
	}

	@State private(set) var loadableUrl: Loadable<Bool> = .notRequested {
		didSet {
			switch loadableUrl {
			case .loaded:
				isLoading = false
				customServer.customServerURL = serverURL
				customServer.isSelectedCustomServer = true
				navigateToLogin = true
			case .failed(let error):
				isLoading = false
				self.error = HomeErrorView(error)
				self.isShowError = true
			case .isLoading:
				isLoading = true
			default: break
			}
		}
	}
	@StateObject var callViewModel: CallViewModel = CallViewModel()
	
	@State private(set) var servers: [ServerViewModel] = []
	@State private(set) var searchKeyword: String = ""
	@State private(set) var searchInputStyle: TextInputStyle = .default
	@State private(set) var isShowMenu: Bool = false
	@State private(set) var isAddNewServer: Bool = false
	@State private(set) var groups: [GroupViewModel] = []
	@State private(set) var peers: [GroupViewModel] = []
	@State private(set) var user: [UserViewModel] = [UserViewModel]()
	@State private var isLoading: Bool = false
	@State private var isShowError: Bool = false
	@State private var error: HomeErrorView?
	@State private var isInCall = false
	
	let inspection = ViewInspector<Self>()

	// MARK: - Body
	var body: some View {
		NavigationView {
			GeometryReader { geometry in
				ZStack {
					HStack {
						ListServerView(servers: $servers, isAddNewServer: $isAddNewServer, action: getServerInfo)
						VStack(spacing: Constants.spacing) {
							HStack {
								Text(serverName)
									.font(AppTheme.shared.fontSet.font(style: .display3))
									.foregroundColor(titleColor)
								Spacer()
								ImageButton(AppTheme.shared.imageSet.menuIcon) {
									withAnimation {
										isShowMenu.toggle()
									}
								}
								.foregroundColor(titleColor)
							}
							content
								.padding(.top, Constants.padding)
						}
						.padding(Constants.padding)
					}
					.hiddenNavigationBarStyle()
					.padding(.top, Constants.paddingTop)
					.hideKeyboardOnTapped()
					NavigationLink(destination: ChatView(inputStyle: .default, groupId: selectedGroupId, avatarLink: ""), isActive: $navigateToChat) {
						EmptyView()
					}
					NavigationLink(
						destination: LoginView(customServer: customServer, navigateToHome: navigateToLogin, rootIsActive: $navigateToLogin),
						isActive: $navigateToLogin,
						label: {
						})
				}
				.hiddenNavigationBarStyle()
				
				if isShowMenu {
					LinearGradient(gradient: Gradient(colors: colorScheme == .light ? AppTheme.shared.colorSet.gradientPrimary.compactMap({ $0.opacity(Constants.opacity) }) : AppTheme.shared.colorSet.gradientBlack), startPoint: .leading, endPoint: .trailing)
						.blur(radius: Constants.blur)
						.edgesIgnoringSafeArea(.vertical)
					MenuView(isShowMenu: $isShowMenu, user: $user, chageStatus: { status in
						self.changeStatus(status: status)
					}, servers: $servers)
						.frame(width: geometry.size.width)
						.offset(x: isShowMenu ? 0 : geometry.size.width * 2)
						.transition(.move(edge: .trailing))
						.animation(.default, value: Constants.duration)
						.ignoresSafeArea()
						.padding(.top, Constants.paddingMenu)
				}
			}
			.hiddenNavigationBarStyle()
			.onAppear(perform: getServers)
			.onAppear(perform: getServerInfo)
			.onReceive(NotificationCenter.default.publisher(for: NSNotification.LogOut, object: nil), perform: { _ in
				self.serverInfo()
				self.getServers()
			})
			.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.SubscribeAndListenService.didReceiveMessage)) { (obj) in
				print("received message banner...... \(obj)")
				if let userInfo = obj.userInfo,
				   let message = userInfo["message"] as? IMessageModel {
					if message.groupType == "group" {
						let groupName = injected.interactors.homeInteractor.getGroupName(groupID: message.groupId)
						let senderName = injected.interactors.homeInteractor.getSenderName(fromClientId: message.senderId, groupID: message.groupId)
						self.messageData = MessagerBannerViewModifier.MessageData(groupName: groupName, senderName: senderName, message: message.message)
					} else {
						let senderName = injected.interactors.homeInteractor.getSenderName(fromClientId: message.senderId, groupID: message.groupId)
						self.messageData = MessagerBannerViewModifier.MessageData(senderName: senderName, message: message.message)
					}
					self.selectedGroupId = message.groupId
					self.showMessageBanner = true
				}
			}
			.onReceive(inspection.notice) { self.inspection.visit(self, $0) }
			.hiddenNavigationBarStyle()
		}
		.alert(isPresented: $isShowError) {
			Alert(title: Text(self.error?.title ?? ""),
				  message: Text(self.error?.message ?? ""),
				  dismissButton: .default(Text(error?.primaryButtonTitle ?? "")))
		}
		.messagerBannerModifier(data: $messageData, show: $showMessageBanner, onTap: {
			navigateToChat = true
		})
		.inCallModifier(callViewModel: callViewModel, isInCall: $isInCall)

	}
}

// MARK: - Private
private extension HomeView {
	var content: AnyView {
		if isAddNewServer {
			return AnyView(JoinServerView(serverURL: serverURL, checkUrl: { urlString in
				serverURL = urlString
				loadableUrl = .isLoading(last: nil, cancelBag: CancelBag())
				Task {
					loadableUrl = await injected.interactors.homeInteractor.workspaceInfo(workspaceDomain: urlString)
				}
			}).progressHUD(isLoading))
		} else {
			return AnyView(HomeContentView(groups: $groups, peers: $peers, serverName: .constant(serverName), isExpandGroup: $isExpandGroup, isExpandDirectMessage: $isExpandDirectMessage).progressHUD(isLoading))
		}
	}
	
	var titleColor: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.greyLight
	}
	
	var serverName: String {
		if let selectedServer = servers.filter({ $0.isActive == true }).first, !isAddNewServer {
			return selectedServer.serverName
		} else {
			return "JoinServer.Title".localized
		}
	}
}

// MARK: - Interactors
private extension HomeView {
	func getServers() {
		servers = injected.interactors.homeInteractor.getServers()
	}
	
	func getServerInfo() {
		Task {
			loadable = await injected.interactors.homeInteractor.getServerInfo()
		}
	}
	
	func serverInfo() {
		self.loadable = .isLoading(last: nil, cancelBag: CancelBag())
		Task {
			loadable = await injected.interactors.homeInteractor.getServerInfo()
		}
	}
	
	func changeStatus(status: StatusType) {
		self.loadableStatus = .isLoading(last: nil, cancelBag: CancelBag())
		Task {
			loadableStatus = await injected.interactors.homeInteractor.updateStatus(status: status.rawValue)
		}
	}
}

// MARK: - extension
extension NSNotification {
	static let LogOut = Notification.Name.init("LogOut")
}

// MARK: - Preview
#if DEBUG
struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
#endif
