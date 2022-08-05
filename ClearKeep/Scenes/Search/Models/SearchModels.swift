//
//  SearchModels.swift
//  ClearKeep
//
//  Created by MinhDev on 22/04/2022.
//

import UIKit
import SwiftUI
import Networking
import Model

protocol ISearchModels {
	var groupModel: [IGroupModel]? { get }
	var userModel: IUser? { get }
	var members: [IUser]? { get }
}

struct SearchModels {
	var groupModel: [IGroupModel]?
	var userModel: IUser?
	var members: [IUser]?
}

extension SearchModels: ISearchModels {
	init(responseGroup: [GroupModel]) {
		self.init(groupModel: responseGroup)
	}
	
	init(responseUser: User_UserProfileResponse) {
		self.init(userModel: UserModel(response: responseUser))
	}
	
	init(responseUser: User_MemberInfoRes?, members: [User_MemberInfoRes]) {
		let memberTeams = members.map { item -> UserModel in
			return UserModel(response: item)
		}
		self.init(userModel: UserModel(response: responseUser), members: memberTeams)
	}
}
