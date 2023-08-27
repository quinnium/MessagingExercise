//
//  LandingViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation
import RealmSwift

final class LandingViewModel: ObservableObject {
    
    private let databaseManager = DatabaseManager()
    private let mockingService  = MockingService()
    
    @Published var profileOne: Profile?
    @Published var profileTwo: Profile?
    
    var profilesExist: Bool {
        (profileOne != nil && profileTwo != nil)
    }
    
    init() {
        fetchProfiles()
    }
    
    func fetchProfiles() {
        profileOne = mockingService.firstProfile
        profileTwo = mockingService.secondProfile
    }
    
    func deleteAllMessages() {
        databaseManager.deleteAllmessagesInMemory()
    }
    
    func generateMockProfiles() {
        mockingService.generateProfiles()
        fetchProfiles()
    }
    
    func generateMockMessages() {
        mockingService.generateMessages()
    }
    
    func getCorrespondingFriend(for profile: Profile) -> Profile? {
        if profile.id == mockingService.firstProfile?.id {
            return mockingService.secondProfile
        } else if profile.id == mockingService.secondProfile?.id {
            return mockingService.firstProfile
        } else {
            return nil
        }
    }
}
