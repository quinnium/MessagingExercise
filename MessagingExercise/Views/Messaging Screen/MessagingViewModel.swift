//
//  MessagingViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation
import RealmSwift

enum MessagingSectionOptions {
    case chat, profile
}

final class MessagingViewModel: ObservableObject {
    
    let user: Profile
    let friend: Profile
    @Published var selectedSection: MessagingSectionOptions = .chat
    
    init(user: Profile, friend: Profile) {
        self.user = user
        self.friend = friend
    }
}
