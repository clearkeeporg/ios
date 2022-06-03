//
//  AppEnvironment.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 09.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

// swiftlint:disable multiline_arguments
import UIKit
import Combine
import Common
import ChatSecure

struct AppEnvironment {
	let container: DIContainer
	let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
	
	static func bootstrap() -> AppEnvironment {
		let appState = Store<AppState>(AppState())
		appState[\.authentication.servers] = DependencyResolver.shared.channelStorage.getServers().compactMap { ServerModel($0) }
		let interactors = configuredInteractors(appState: appState)
		let diContainer = DIContainer(appState: appState, interactors: interactors)
		let deepLinksHandler = DeepLinksHandler(container: diContainer)
		let pushNotificationsHandler = PushNotificationsHandler(deepLinksHandler: deepLinksHandler)
		let systemEventsHandler = SystemEventsHandler(
			container: diContainer, deepLinksHandler: deepLinksHandler,
			pushNotificationsHandler: pushNotificationsHandler)
		
		return AppEnvironment(container: diContainer,
							  systemEventsHandler: systemEventsHandler)
	}
	
	private static func configuredInteractors(appState: Store<AppState>) -> DIContainer.Interactors {
		let homeInteractor = HomeInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService, groupService: DependencyResolver.shared.groupService, userService: DependencyResolver.shared.userService)
		let loginInteractor = LoginInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, socialAuthenticationService: DependencyResolver.shared.socialAuthenticationService, authenticationService: DependencyResolver.shared.authenticationService, appTokenService: DependencyResolver.shared.appTokenService)
		let twoFactorInteractor = TwoFactorInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService)
		let registerInteractor = RegisterInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService)
		let socialInteractor = SocialInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService, appTokenService: DependencyResolver.shared.appTokenService)
		let fogotPasswordInteractor = FogotPasswordInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService)
		let newPasswordInteractor = NewPasswordInteractor(appState: appState, authenticationService: DependencyResolver.shared.authenticationService)
		let changePasswordInteractor = ChangePasswordInteractor(appState: appState, channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService)

		return .init(homeInteractor: homeInteractor,
					 loginInteractor: loginInteractor,
					 twoFactorInteractor: twoFactorInteractor,
					 registerInteractor: registerInteractor,
					 socialInteractor: socialInteractor,
					 fogotPasswordInteractor: fogotPasswordInteractor,
					 newPasswordInteractor: newPasswordInteractor,
					 changePasswordInteractor: changePasswordInteractor)
	}
}

extension DIContainer {
}
