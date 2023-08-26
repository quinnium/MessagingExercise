//
//  ComposeMessageViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 26/08/2023.
//

import Foundation
import RealmSwift

final class ComposeMessageViewModel: ObservableObject {
    
    private let user: Profile
    private let friend: Profile
    private let databaseManager = DatabaseManager()
    
    @Published var messageText = ""
    
    init(user: Profile, friend: Profile) {
        self.user = user
        self.friend = friend
    }
    
    func sendMessageResponse() {
        databaseManager.addMessage(from: user.id, to: friend.id, messageText: messageText, isSystemMessage: false, dateSent: Date())
    }
}
