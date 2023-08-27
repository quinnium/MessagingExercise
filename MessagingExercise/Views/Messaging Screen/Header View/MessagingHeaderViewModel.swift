//
//  MessagingHeaderViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation

final class MessagingHeaderViewModel: ObservableObject {
    
    let user: Profile
    let friend: Profile
    
    init(user: Profile, friend: Profile) {
        self.user   = user
        self.friend = friend
    }
    
    func callFriend() {
        print("Calling \(friend.name)")
    }
    
    func videoCallFriend() {
        print("Video calling \(friend.name)")
    }
    
    func reportFriend() {
        print("Repoting \(friend.name)")
    }
    
    func blockFriend() {
        print("Blocking \(friend.name)")
    }
}
