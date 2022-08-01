//
//  HomeInteractor.swift
//  iOSBase-SwiftUI
//
//  Created by NamNH on 15/02/2022.
//

import Common
import ChatSecure
import Model
import CommonUI

protocol IHomeInteractor {
	var worker: IHomeWorker { get }
	
	func validateDomain(_ domain: String) -> Bool
	func registerToken(_ token: Data)
	func subscribeAndListenServers()
	func getServers() -> [ServerViewModel]
	func getServerInfo() async -> Loadable<HomeViewModels>
	func didSelectServer(_ domain: String?) -> [ServerViewModel]
	func signOut() async
	func updateStatus(status: String) async -> Loadable<UserViewModels>

	func removeServer() async
}

struct HomeInteractor {
	let appState: Store<AppState>
	let channelStorage: IChannelStorage
	let authenticationService: IAuthenticationService
	let groupService: IGroupService
	let userService: IUserService
}

extension HomeInteractor: IHomeInteractor {
	var worker: IHomeWorker {
		let remoteStore = HomeRemoteStore(authenticationService: authenticationService, groupService: groupService, userService: userService)
		let inMemoryStore = HomeInMemoryStore()
		return HomeWorker(channelStorage: channelStorage, remoteStore: remoteStore, inMemoryStore: inMemoryStore)
	}
	
	func validateDomain(_ domain: String) -> Bool {
		return worker.validateDomain(domain)
	}
	
	func registerToken(_ token: Data) {
		worker.registerToken(token)
	}
	
	func subscribeAndListenServers() {
		worker.subscribeAndListenServers()
	}
	
	func getServers() -> [ServerViewModel] {
		return worker.servers.compactMap { ServerViewModel($0) }
	}

	func removeServer() async {
		_ = await worker.removeServer()
	}

	func getServerInfo() async -> Loadable<HomeViewModels> {
		let result = await worker.getJoinedGroup()
		await worker.pingRequest()
		
		switch result {
		case .success(let groups):
			var ids: [String] = []
		    groups.groupModel?.forEach({ data in
				let idMembers = data.groupMembers.map({ $0.userId })
				ids.append(contentsOf: idMembers)
			})
			ids.append(DependencyResolver.shared.channelStorage.currentServer?.profile?.userId ?? "")
			let result = await worker.getListStatus(ids: Array(Set(ids)))

			switch result {
			case .success(let user):
				return .loaded(HomeViewModels(responseGroup: groups, responseUser: user))
			case .failure(let error):
				return .failed(error)
			}
		case .failure(let error):
			return .failed(error)
		}
	}
	
	func updateStatus(status: String) async -> Loadable<UserViewModels> {
		let result = await worker.updateStatus(status: status)
		switch result {
		case .success:
			let result = await worker.getListStatus(ids: [DependencyResolver.shared.channelStorage.currentServer?.profile?.userId ?? ""])
			switch result {
			case .success(let user):
				return .loaded(UserViewModels(user))
			case .failure(let error):
				return .failed(error)
			}
		case .failure(let error):
			return .failed(error)
		}
	}
	
	func didSelectServer(_ domain: String?) -> [ServerViewModel] {
		return worker.didSelectServer(domain).compactMap { ServerViewModel($0) }
	}
	
	func signOut() async {
		_ = await worker.signOut()
	}
}

struct StubHomeInteractor: IHomeInteractor {
	let channelStorage: IChannelStorage
	let authenticationService: IAuthenticationService
	let groupService: IGroupService
	let userService: IUserService
	
	var worker: IHomeWorker {
		let remoteStore = HomeRemoteStore(authenticationService: authenticationService, groupService: groupService, userService: userService)
		let inMemoryStore = HomeInMemoryStore()
		return HomeWorker(channelStorage: channelStorage, remoteStore: remoteStore, inMemoryStore: inMemoryStore)
	}
	
	func validateDomain(_ domain: String) -> Bool {
		return true
	}
	
	func registerToken(_ token: Data) {
		worker.registerToken(token)
	}
	
	func subscribeAndListenServers() {
		worker.subscribeAndListenServers()
	}
	
	func getServers() -> [ServerViewModel] {
		return []
	}
	
	func getServerInfo() async -> Loadable<HomeViewModels> {
		return .notRequested
	}
	
	func didSelectServer(_ domain: String?) -> [ServerViewModel] {
		return []
	}
	
	func signOut() async {
		_ = await worker.signOut()
	}
	
	func updateStatus(status: String) async -> Loadable<UserViewModels> {
		return .notRequested
	}

	func removeServer() async {
		_ = await worker.removeServer()
	}

}
