//
//  DatabaseManagerTests.swift
//  MessagingExerciseTests
//
//  Created by Quinn on 27/08/2023.
//

import XCTest
@testable import MessagingExercise

final class DatabaseManagerTests: XCTestCase {

    var sut: DatabaseManager!
    
    override func setUp() {
        super.setUp()
        sut = DatabaseManager(forTesting: true)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddAndFetchProfile() {
        let testName = "abcdefghijklmnopqrstuvwxyzTest123"
        sut.addProfile(name: testName, imageURLString: "", bioText: "Bio Test")
        let fetchedProfile = sut.fetchProfileForName(name: testName)
        XCTAssertNotNil(fetchedProfile)
    }
    
    func testFetchProfileByID() {
        // Create profile and write it to database
        let testName = "abcdefghijklmnopqrstuvwxyzTest123"
        let testBio = "Bio Test"
        sut.addProfile(name: testName, imageURLString: "", bioText: testBio)
        let fetchedProfile = sut.fetchProfileForName(name: testName)

        let newlyCreatedProfileID = fetchedProfile!.id
        let fetchedPofile = sut.fetchProfile(withId: newlyCreatedProfileID)
        XCTAssertNotNil(fetchedPofile)
        XCTAssertEqual(fetchedPofile?.name, testName)
        XCTAssertEqual(fetchedPofile?.bioText, testBio)
    }
    
    func testAddingAndFetchingMessages() {
        let profileOneName = "A"
        sut.addProfile(name: profileOneName, imageURLString: "", bioText: "")
        let profileOneID = sut.fetchProfileForName(name: "A")!.id
        
        let profileTwoName = "B"
        sut.addProfile(name: profileTwoName, imageURLString: "", bioText: "")
        let profileTwoID = sut.fetchProfileForName(name: "B")!.id
        
        let messageTextOne = "MessageOne"
        sut.addMessage(from: profileOneID, to: profileTwoID, messageText: messageTextOne, isSystemMessage: false)
        let messageTextTwo = "MessageTwo"
        sut.addMessage(from: profileTwoID, to: profileOneID, messageText: messageTextTwo, isSystemMessage: false)
        
        let fetchedMessages = sut.getMessagesBetween(profileOne: profileOneID, profileTwo: profileTwoID)
        let expectedCount = 2
        XCTAssertEqual(fetchedMessages.count, expectedCount)
    }

    func testDeleteAllMessagesInMemory() {
        let profileOneName = "A"
        sut.addProfile(name: profileOneName, imageURLString: "", bioText: "")
        let profileOneID = sut.fetchProfileForName(name: "A")!.id

        let profileTwoName = "B"
        sut.addProfile(name: profileTwoName, imageURLString: "", bioText: "")
        let profileTwoID = sut.fetchProfileForName(name: "B")!.id

        let messageTextOne = "MessageOne"
        sut.addMessage(from: profileOneID, to: profileTwoID, messageText: messageTextOne, isSystemMessage: false)
        let messageTextTwo = "MessageTwo"
        sut.addMessage(from: profileTwoID, to: profileOneID, messageText: messageTextTwo, isSystemMessage: false)

        sut.deleteAllmessagesInMemory()

        let fetchedMessages = sut.realm.objects(Message.self)
        let expectedCount = 0
        XCTAssertEqual(fetchedMessages.count, expectedCount)

    }
    
}
