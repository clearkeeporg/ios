//
//  RegisterView.swift
//  ClearKeep
//
//  Created by MinhDev on 04/03/2022.
//

import SwiftUI
import Combine
import Common
import CommonUI

private enum Constants {
	static let widthReView = UIScreen.main.bounds.width - 20
	static let minSpacer = 50.0
	static let heightLogo = 120.0
	static let widthLogo = 160.0
	static let spacing = 30.0
}

struct RegisterView: View {
	// MARK: - Constants
	private let inspection = ViewInspector<Self>()
	// MARK: - Variables
	@Environment(\.injected) private var injected: DIContainer
	@Environment(\.colorScheme) var colorScheme
	@State private(set) var samples: Loadable<[IRegisterModel]>
	@State private(set) var emails: String
	@State private(set) var displayname: String
	@State private(set) var password: String
	@State private(set) var rePassword: String
	@State private(set) var emailStyle: TextInputStyle = .default
	@State private(set) var nameStyle: TextInputStyle = .default
	@State private(set) var passwordStyle: TextInputStyle = .default
	@State private(set) var rePasswordStyle: TextInputStyle = .default
	
	init(samples: Loadable<[IRegisterModel]> = .notRequested,
		 email: String = "",
		 username: String = "",
		 displayname: String = "",
		 password: String = "",
		 rePassword: String = "",
		 emailStyle: TextInputStyle = .default,
		 nameStyle: TextInputStyle = .default,
		 passwordStyle: TextInputStyle = .default,
		 rePasswordStyle: TextInputStyle = .default) {
	self._samples = .init(initialValue: samples)
	self._emails = .init(initialValue: email)
	self._displayname = .init(initialValue: displayname)
	self._password = .init(initialValue: password)
	self._rePassword = .init(initialValue: rePassword)
	self._emailStyle = .init(initialValue: emailStyle)
	self._nameStyle = .init(initialValue: nameStyle)
	self._passwordStyle = .init(initialValue: passwordStyle)
	self._rePasswordStyle = .init(initialValue: rePasswordStyle)
}
	// MARK: - Body
	var body: some View {
		NavigationView {
			content
				.onReceive(inspection.notice) { inspection.visit(self, $0) }
		}
	}
}
// MARK: - Private variable
private extension RegisterView {
	var backgroundColorView: LinearGradient {
		colorScheme == .light ? backgroundColorGradient : backgroundColorBlack
	}
	var backgroundColorBlack: LinearGradient {
		LinearGradient(gradient: Gradient(colors: AppTheme.shared.colorSet.gradientBlack), startPoint: .leading, endPoint: .trailing)
	}
	var backgroundColorGradient: LinearGradient {
		LinearGradient(gradient: Gradient(colors: AppTheme.shared.colorSet.gradientPrimary), startPoint: .leading, endPoint: .trailing)
	}
}
// MARK: - Private
private extension RegisterView {
	var content: AnyView {
		AnyView(notRequestedView)
	}
}
// MARK: - Loading Content
private extension RegisterView {
	var notRequestedView: some View {
		VStack(spacing: Constants.spacing) {
			Spacer()
			AppTheme.shared.imageSet.logo
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: Constants.widthLogo, height: Constants.heightLogo)
			RegisterContentView(email: $emails, password: $password, displayname: $displayname, rePassword: $rePassword, emailStyle: $emailStyle, nameStyle: $nameStyle, passwordStyle: $passwordStyle, rePasswordStyle: $rePasswordStyle)
				.frame(width: Constants.widthReView)
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(backgroundColorView)
		.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
	}
}
// MARK: - Interactors
private extension RegisterView {
}

// MARK: - Preview
#if DEBUG
struct RegisterView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterView()
	}
}
#endif
