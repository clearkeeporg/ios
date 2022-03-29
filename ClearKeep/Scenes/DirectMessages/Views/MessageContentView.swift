//
//  MessageContentView.swift
//  ClearKeep
//
//  Created by MinhDev on 29/03/2022.
//

import SwiftUI
import Common
import CommonUI

private enum Constants {
	static let spacing = 10.0
	static let padding = 20.0
	static let sizeImage = 64.0
	static let paddingTop = 50.0
	static let sizeIcon = 18.0
	static let radius = 80.0
	static let paddingHorizontal = 80.0
	static let paddingButton = 12.0
}

struct MessageContentView: View {
	// MARK: - Constants
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

	// MARK: - Variables
	@Environment(\.injected) private var injected: DIContainer
	@Binding var imageUser: Image
	@Binding var userName: String
	@Binding var searchText: String
	@Binding var severText: String
	@Binding var inputStyle: TextInputStyle
	@State private(set) var isShowingLinkUser: Bool = false
	@State private(set) var isShowingUser: Bool = false
	// MARK: - Init
	init(imageUser: Binding<Image>,
		 userName: Binding<String>,
		 searchText: Binding<String>,
		 severText: Binding<String>,
		 inputStyle: Binding<TextInputStyle>) {
		self._imageUser = imageUser
		self._userName = userName
		self._searchText = searchText
		self._severText = severText
		self._inputStyle = inputStyle
	}

	// MARK: - Body
	var body: some View {
		content
			.navigationBarTitle("")
			.navigationBarHidden(true)
			.background(backgroundColorView)
			.edgesIgnoringSafeArea(.all)
	}
}

// MARK: - Private
private extension MessageContentView {
	var content: AnyView {
		AnyView(contentView)
	}

	var buttonBack: AnyView {
		AnyView(buttonBackView)
	}

	var buttonAddUser: AnyView {
		AnyView(checkMaskButton)
	}

	var user: AnyView {
		AnyView(userView)
	}

	var addSeverTextfield: AnyView {
		AnyView(addSeverTextfieldView)
	}
}

// MARK: - Private Variables
private extension MessageContentView {
	var backgroundColorView: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.background : AppTheme.shared.colorSet.black
	}

	var backgroundButtonImage: LinearGradient {
		LinearGradient(gradient: Gradient(colors: AppTheme.shared.colorSet.gradientPrimary), startPoint: .leading, endPoint: .trailing)
	}

	var foregroundColorUserName: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.greyLight
	}

	var foregroundBackButton: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.greyLight2
	}

	var backgroundNextButton: LinearGradient {
		colorScheme == .light ? backgroundButtonImage : backgroundButtonImage
	}

	var foregroundCheckmask: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.greyLight2
	}
}

// MARK: - Private func
private extension MessageContentView {
	func customBack() {
		self.presentationMode.wrappedValue.dismiss()
	}

	func nextAction() {

	}

	func chooseUser() {

	}
}

// MARK: - Loading Content
private extension MessageContentView {
	var contentView: some View {
		VStack(alignment: .leading, spacing: Constants.spacing) {
			buttonBack
				.padding(.top, Constants.paddingTop)
				.frame(maxWidth: .infinity, alignment: .leading)
			SearchTextField(searchText: $searchText,
							inputStyle: $inputStyle,
							inputIcon: AppTheme.shared.imageSet.searchIcon,
							placeHolder: "General.Search".localized,
							onEditingChanged: { isEditing in
				if isEditing {
					isShowingLinkUser = false
				}
			})
			buttonAddUser
			if isShowingLinkUser {
				addSeverTextfieldView
			} else {
				user
			}
			Spacer()
		}
		.padding([.horizontal, .bottom], Constants.padding)
	}

	var userView: some View {
		Button(action: chooseUser) {
			VStack(alignment: .leading, spacing: Constants.spacing) {
				HStack {
					imageUser
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: Constants.sizeImage, height: Constants.sizeImage)
						.clipShape(Circle())
					Text(userName)
						.font(AppTheme.shared.fontSet.font(style: .body2))
						.foregroundColor(foregroundColorUserName)
					Spacer()
				}
			}
		}
	}

	var checkMaskButton: some View {
		CheckBoxButtons(text: "DirectMessages.AddUserTitle".localized, isChecked: $isShowingLinkUser)
			.foregroundColor(foregroundCheckmask)
	}

	var addSeverTextfieldView: some View {
		VStack {
			CommonTextField(text: $severText,
							inputStyle: $inputStyle,
							placeHolder: "DirectMessages.LinkTitle".localized,
							onEditingChanged: { _ in })
			Spacer()
			Button(action: nextAction) {
				HStack(spacing: Constants.spacing) {
					Text("DirectMessages.Next".localized)
						.padding(.vertical, Constants.paddingButton)
						.padding(.horizontal, Constants.paddingHorizontal)
						.font(AppTheme.shared.fontSet.font(style: .body2))
						.foregroundColor(AppTheme.shared.colorSet.offWhite)
				}
			}
			.background(backgroundNextButton)
			.cornerRadius(Constants.radius)
		}
	}

	var buttonBackView: some View {
		Button(action: customBack) {
			HStack(spacing: Constants.spacing) {
				AppTheme.shared.imageSet.chevleftIcon
					.renderingMode(.template)
					.aspectRatio(contentMode: .fit)
					.foregroundColor(foregroundBackButton)
				Text("DirectMessages.TitleButton".localized)
					.padding(.all)
					.font(AppTheme.shared.fontSet.font(style: .body2))
			}
			.foregroundColor(foregroundBackButton)
		}
	}
}

// MARK: - Interactor
private extension MessageContentView {
}

// MARK: - Preview
#if DEBUG
struct MessageContentView_Previews: PreviewProvider {
	static var previews: some View {
		MessageContentView(imageUser: .constant(Image("")), userName: .constant(""), searchText: .constant(""), severText: .constant(""), inputStyle: .constant(.default))
	}
}
#endif
