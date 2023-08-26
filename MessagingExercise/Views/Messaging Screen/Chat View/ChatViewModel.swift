//
//  ChatViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 22/08/2023.
//

import Foundation
import RealmSwift

final class ChatViewModel: ObservableObject {
    
    let user: Profile
    let friend: Profile
    @Published var messages: Results<Message>?
    
    let databaseManager = DatabaseManager()
    
    init(user: Profile, friend: Profile) {
        self.user = user
        self.friend = friend
        configureDelegate()
        fetchMessages()
    }

    func configureDelegate() {
        databaseManager.delegate = self
    }
    
    func fetchMessages() {
        messages = databaseManager.getMessagesBetween(profileOne: user.id, profileTwo: friend.id)
    }
    
    func getPreviousMessageDate(for message: Message) -> Date? {
        let previousMessage = messages?.last { $0.dateSent < message.dateSent }
        return previousMessage?.dateSent
    }
    
    func getPreviousMessageSenderID(for currentMessage: Message) -> ObjectId? {
        guard messages != nil && messages!.count > 0 else { return nil }
        guard let previousMessage = messages!.last(where: { $0.dateSent < currentMessage.dateSent }) else { return nil }
        return previousMessage.from
    }
}

extension ChatViewModel: DatabaseResultsChangedProtocol {
    func resultsChanged(deletions: [Int], insertions: [Int], modifications: [Int]) {
        print("deletions: \(deletions)")
        print("insertions: \(insertions)")
        print("modifications: \(modifications)")
        fetchMessages()
    }
}
