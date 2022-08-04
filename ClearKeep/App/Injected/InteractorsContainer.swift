//
//  DIContainer.Interactors.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 24.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import CommonUI

extension DIContainer {
	struct Interactors {
		let homeInteractor: IHomeInteractor
		let loginInteractor: ILoginInteractor
		let twoFactorInteractor: ITwoFactorInteractor
		let registerInteractor: IRegisterInteractor
		let socialInteractor: ISocialInteractor
		let fogotPasswordInteractor: IFogotPasswordInteractor
		let newPasswordInteractor: INewPasswordInteractor
		let changePasswordInteractor: IChangePasswordInteractor
		let chatGroupInteractor: IChatGroupInteractor
		let chatInteractor: IChatInteractor
		let createDirectMessageInteractor: ICreateDirectMessageInteractor
		let groupDetailInteractor: IGroupDetailInteractor
		let peerCallInteractor: IPeerCallInteractor
		let profileInteractor: IProfileInteractor
		let searchInteractor: ISearchInteractor
		let advancedSeverInteractor: IAdvancedSeverInteractor

		static var stub: Self {
			.init(homeInteractor: StubHomeInteractor(channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService, groupService: DependencyResolver.shared.groupService, userService: DependencyResolver.shared.userService),
				  loginInteractor: StubLoginInteractor(channelStorage: DependencyResolver.shared.channelStorage, socialAuthenticationService: DependencyResolver.shared.socialAuthenticationService, authenticationService: DependencyResolver.shared.authenticationService),
				  twoFactorInteractor: StubTwoFactorInteractor(channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService),
				  registerInteractor: StubRegisterInteractor(channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService),
				  socialInteractor: StubSocialInteractor(channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService),
				  fogotPasswordInteractor: StubFogotPasswordInteractor(channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService),
				  newPasswordInteractor: StubNewPasswordInteractor(authenticationService: DependencyResolver.shared.authenticationService),
				  changePasswordInteractor: StubChangePasswordInteractor(channelStorage: DependencyResolver.shared.channelStorage, authenticationService: DependencyResolver.shared.authenticationService, userService: DependencyResolver.shared.userService),
				  chatGroupInteractor: StubChatGroupInteractor(channelStorage: DependencyResolver.shared.channelStorage, groupService: DependencyResolver.shared.groupService, userService: DependencyResolver.shared.userService),
				  chatInteractor: StubChatInteractor(channelStorage: DependencyResolver.shared.channelStorage, groupService: DependencyResolver.shared.groupService, messageService: DependencyResolver.shared.messageService, uploadFileService: DependencyResolver.shared.uploadFileService, realmManager: DependencyResolver.shared.realmManager, callService: DependencyResolver.shared.callService),
				  createDirectMessageInteractor: StubCreateDirectMessageInteractor(channelStorage: DependencyResolver.shared.channelStorage, userService: DependencyResolver.shared.userService, groupService: DependencyResolver.shared.groupService),
				  groupDetailInteractor: StubGroupDetailInteractor(groupService: DependencyResolver.shared.groupService, userService: DependencyResolver.shared.userService, channelStorage: DependencyResolver.shared.channelStorage),
				  peerCallInteractor: StubPeerCallInteractor(channelStorage: DependencyResolver.shared.channelStorage, callService: DependencyResolver.shared.callService),
				  profileInteractor: StubProfileInteractor(channelStorage: DependencyResolver.shared.channelStorage, userService: DependencyResolver.shared.userService),
				  searchInteractor: StubSearchInteractor(channelStorage: DependencyResolver.shared.channelStorage, groupService: DependencyResolver.shared.groupService, userService: DependencyResolver.shared.userService, messageService: DependencyResolver.shared.messageService),
				  advancedSeverInteractor: StubAdvancedSeverInteractor(channelStorage: DependencyResolver.shared.channelStorage, workspaceService: DependencyResolver.shared.workspaceService))
		}
	}
}
