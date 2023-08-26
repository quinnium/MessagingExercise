//
//  ProfileViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 26/08/2023.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
}
