//
//  LoginView.swift
//  ClearKeep
//
//  Created by đông on 02/03/2022.
//
import SwiftUI
import Combine
import Common
import CommonUI
import Model
import ChatSecure

private enum Constants {
	static let inputViewSpacing = 24.0
	static let extraButtonViewHeight = 22.0
	static let extraButtonViewPaddingTop = 16.0
	static let separateLineHeight = 1.0
	static let separateLinePaddingTop = 32.0
	static let socialViewPaddingTop = 24.0
	static let socialViewSpacing = 40.0
	static let signUpViewPaddingTop = 45.0
	static let appVersionPaddingTop = 30.0
}

struct LoginContentView: View {
	// MARK: - Variables
	@Environment(\.injected) private var injected: DIContainer
	@Environment(\.colorScheme) var colorScheme
	@Binding var loadable: Loadable<IAuthenticationModel>
	@Binding var customServer: CustomServer
	@State private var email: String = ""
	@State private var password: String = ""
	@State private var emailStyle: TextInputStyle = .default
	@State private var passwordStyle: TextInputStyle = .default
	@State private var appVersion: String = "General.Version".localized
	@State private var editingEmail = false
	@State private var editingPassword = false
	@State private var isAdvanceServer: Bool = false
	@State private var isForgotPassword: Bool = false
	@State private var isRegister: Bool = false
	
	// MARK: - Init
	
	// MARK: - Body
	var body: some View {
		VStack {
			inputView
			extraButtonView
				.frame(height: Constants.extraButtonViewHeight)
				.padding(.top, Constants.extraButtonViewPaddingTop)
			Rectangle()
				.frame(height: Constants.separateLineHeight)
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
				.padding(.top, Constants.separateLinePaddingTop)
			socialView
				.padding(.top, Constants.socialViewPaddingTop)
			signUpView
				.padding(.top, Constants.signUpViewPaddingTop)
			
			Text(appVersion)
				.font(AppTheme.shared.fontSet.font(style: .placeholder3))
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
				.onAppear(perform: {
					getAppVersion()
				})
				.padding(.top, Constants.appVersionPaddingTop)
		}
	}
}

// MARK: - Private
private extension LoginContentView {
}

// MARK: - Loading Content
private extension LoginContentView {
	var inputView: some View {
		VStack(spacing: Constants.inputViewSpacing) {
			CommonTextField(text: $email,
							inputStyle: $emailStyle,
							inputIcon: AppTheme.shared.imageSet.mailIcon,
							placeHolder: "General.Email".localized,
							keyboardType: .default,
							onEditingChanged: { isEditing in
				if isEditing {
					emailStyle = .highlighted
				} else {
					emailStyle = .normal
				}
			})
			SecureTextField(secureText: $password,
							inputStyle: $passwordStyle,
							inputIcon: AppTheme.shared.imageSet.lockIcon,
							placeHolder: "General.Password".localized,
							keyboardType: .default,
							onEditingChanged: { isEditing in
				if isEditing {
					passwordStyle = .highlighted
				} else {
					passwordStyle = .normal
				}
			})
			RoundedButton("Login.SignIn".localized, action: doLogin)
		}
	}
	
	var extraButtonView: some View {
		HStack {
			NavigationLink(destination: AdvancedSeverView(customServer: $customServer),
						   isActive: $isAdvanceServer,
						   label: {
				LinkButton("Login.AdvancedServerSettings".localized, alignment: .leading, action: advancedServer)
			})
			Spacer()
			NavigationLink(destination: FogotPasswordView(customServer: $customServer),
						   isActive: $isForgotPassword,
						   label: {
				LinkButton("Login.ForgotPassword".localized, alignment: .trailing, action: forgotPassword)
			})
		}
	}
	
	var socialView: some View {
		VStack(alignment: .center, spacing: Constants.socialViewPaddingTop) {
			Text("Login.SignInWith".localized)
				.font(AppTheme.shared.fontSet.font(style: .body3))
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
			HStack(spacing: Constants.socialViewSpacing) {
				SocialButton(AppTheme.shared.imageSet.googleIcon) { doSocialLogin(type: .google) }
				SocialButton(AppTheme.shared.imageSet.officeIcon) { doSocialLogin(type: .office) }
				SocialButton(AppTheme.shared.imageSet.facebookIcon) { doSocialLogin(type: .facebook) }
			}
		}
	}
	
	var signUpView: some View {
		VStack {
			Text("Login.SignUp.Suggest".localized)
				.font(AppTheme.shared.fontSet.font(style: .body3))
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
			
			NavigationLink(destination: RegisterView(customServer: $customServer),
						   isActive: $isRegister,
						   label: {
				RoundedBorderButton("Login.SignUp".localized, action: register)
			})
		}
	}
}

// MARK: - Private func
private extension LoginContentView {
}

// MARK: - Interactors
private extension LoginContentView {
	func getAppVersion() {
		appVersion = injected.interactors.loginInteractor.getAppVersion()
	}
	
	func doLogin() {
		loadable = .isLoading(last: nil, cancelBag: CancelBag())
		Task {
			loadable = await injected.interactors.loginInteractor.signIn(email: email, password: password, customServer: customServer)
		}
	}
	
	func doSocialLogin(type: SocialType) {
		loadable = .isLoading(last: nil, cancelBag: CancelBag())
		Task {
			loadable = await injected.interactors.loginInteractor.signInSocial(type, customServer: customServer)
		}
	}
	
	func advancedServer() {
		isAdvanceServer = true
	}

	func forgotPassword() {
		isForgotPassword = true
	}

	func register() {
		isRegister = true
	}
}

#if DEBUG
struct LoginContentView_Previews: PreviewProvider {
	static var previews: some View {
		LoginContentView(loadable: .constant(.notRequested), customServer: .constant(CustomServer()))
	}
}
#endif
