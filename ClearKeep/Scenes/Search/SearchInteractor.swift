//
//  SearchInteractor.swift
//  ClearKeep
//
//  Created by MinhDev on 05/04/2022.
//

import Common
import ChatSecure
import Model

private enum Constants {
	static let loadSize = 20
}

protocol ISearchInteractor {
	func getJoinedGroup() async -> Loadable<ISearchViewModels>
	func getMessageList(_ keyword: String, groupId: Int64, isGroup: Bool, lastMessageAt: Int64) async -> Result<[RealmMessage], Error>
}

struct SearchInteractor {
	let appState: Store<AppState>
	let channelStorage: IChannelStorage
	let groupService: IGroupService
	let userService: IUserService
	let messageService: IMessageService
}

extension SearchInteractor: ISearchInteractor {
	
	var worker: ISearchWorker {
		let remoteStore = SearchRemoteStore(groupAPIService: groupService, userService: userService, messageService: messageService)
		let inMemoryStore = SearchInMemoryStore()
		return SearchWorker(channelStorage: channelStorage, remoteStore: remoteStore, inMemoryStore: inMemoryStore)
	}
	
	func getJoinedGroup() async -> Loadable<ISearchViewModels> {
		let result = await worker.getJoinedGroup()
		switch result {
		case .success(let groups):
			var ids: [[String: String]] = []
			groups.groupModel?.forEach({ data in
				let idMembers = data.groupMembers.map({ ["id": $0.userId, "domain": $0.domain] })
				ids.append(contentsOf: idMembers)
			})
			ids.append(["id": DependencyResolver.shared.channelStorage.currentServer?.profile?.userId ?? "",
						"domain": DependencyResolver.shared.channelStorage.currentDomain])
			let result = await worker.getListStatus(data: Array(Set(ids)))
			switch result {
			case .success(let user):
				return .loaded(SearchViewModels(responseGroup: groups, responseUser: user))
			case .failure(let error):
				return .failed(error)
			}
		case .failure(let error):
			return .failed(error)
		}
	}
	
	func getMessageList(_ keyword: String, groupId: Int64, isGroup: Bool, lastMessageAt: Int64) async -> Result<[RealmMessage], Error> {
		let result = await worker.getMessageList(groupId: groupId, loadSize: Constants.loadSize, isGroup: isGroup, lastMessageAt: lastMessageAt)
		return result
	}
}

struct StubSearchInteractor: ISearchInteractor {
	
	let channelStorage: IChannelStorage
	let groupService: IGroupService
	let userService: IUserService
	let messageService: IMessageService
	
	var worker: ISearchWorker {
		let remoteStore = SearchRemoteStore(groupAPIService: groupService, userService: userService, messageService: messageService)
		let inMemoryStore = SearchInMemoryStore()
		return SearchWorker(channelStorage: channelStorage, remoteStore: remoteStore, inMemoryStore: inMemoryStore)
	}
	
	func getJoinedGroup() async -> Loadable<ISearchViewModels> {
		return .notRequested
	}
	
	func getMessageList(_ keyword: String, groupId: Int64, isGroup: Bool, lastMessageAt: Int64) async -> Result<[RealmMessage], Error> {
		let result = await worker.getMessageList(groupId: groupId, loadSize: Constants.loadSize, isGroup: isGroup, lastMessageAt: lastMessageAt)
		return result
	}
}
