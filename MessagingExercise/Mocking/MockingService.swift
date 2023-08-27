//
//  MockingService.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation
import RealmSwift

struct MockingService {
    
    private let dbManager = DatabaseManager()
    
    private let firstProfileName            = "Mittens"
    private let secondProfileName           = "Spot"
    private let firstProfileImageUrlString  = "https://dl.dropbox.com/scl/fi/hnl9zpr3ebv9u80asd4iw/cat.png?rlkey=mqpvks1xjlhtpei0mlh5nwqa2"
    private let secondProfileImageUrlString = "https://dl.dropbox.com/scl/fi/t8njummatbuv35ucyjmue/dog.png?rlkey=ywsdn82ge5p9go7r6ulhkm51m"
    private let firstProfileBioText         = "Meow meow prrr meow prrr meow prrr meow prrr meow prrr meow prrr meow prrr meow prrr meow prrr meow prrr meow prrr"
    private let secondProfileBioText        = "Woof woofy woof woofy woof woofy woof woofy woof woofy woof woofy woof woofy woof woofy woof woofy woof woofy woof"
    
    var firstProfile: Profile? {
        dbManager.fetchProfileForName(name: firstProfileName)
    }
    var secondProfile: Profile? {
        dbManager.fetchProfileForName(name: secondProfileName)
    }

    
    func generateProfiles() {
        dbManager.addProfile(name: firstProfileName, imageURLString: firstProfileImageUrlString, bioText: firstProfileBioText)
        dbManager.addProfile(name: secondProfileName, imageURLString: secondProfileImageUrlString, bioText: secondProfileBioText)
    }
    
    func generateMessages() {
        guard let firstProfileID = firstProfile?.id, let secondProfileID = secondProfile?.id else {
            print("Log: Relevant profiles not in existence")
            return
        }
        let baseDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -3, to: Date()) ?? Date()
        // Match message
        let matchMessageDate    = baseDate
        let matchMessageOne     = Message(from: firstProfileID,
                                          to: secondProfileID,
                                          dateSent: matchMessageDate,
                                          text: "You matched 🎈",
                                          isSystemMessage: true)
        let matchMessgeTwo      = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: matchMessageDate,
                                          text: "You matched 🎈",
                                          isSystemMessage: true)
        // First message (2 minutes after match)
        let messageOneDate      = Date(timeInterval: (2*60), since: matchMessageDate)
        let messageOne          = Message(from: firstProfileID,
                                          to: secondProfileID,
                                          dateSent: messageOneDate,
                                          text: "Well this is awkward",
                                          isSystemMessage: false)
        // Message 2 hours later
        let messageTwoDate      = Date(timeInterval: (2*60*60), since: messageOneDate)
        let messageTwo          = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: messageTwoDate,
                                          text: "You're telling me?! 🤔",
                                          isSystemMessage: false)
        // Message 10 seconds later
        let messageThreeDate    = Date(timeInterval: (10), since: messageTwoDate)
        let messageThree        = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: messageThreeDate,
                                          text: "Caught any squirrels lately?",
                                          isSystemMessage: false)
        // Message 10 seconds later
        let messageFourDate     = Date(timeInterval: (15), since: messageThreeDate)
        let messageFour         = Message(from: firstProfileID,
                                          to: secondProfileID,
                                          dateSent: messageFourDate,
                                          text: "😡🐿️🙈",
                                          isSystemMessage: false)
        // Message 1 day later
        let messageFiveDate     = Date(timeInterval: (60*60*24), since: messageFourDate)
        let messageFive         = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: messageFiveDate,
                                          text: "Don't know about you, but I think dogs and cats can live in harmony together... if we pool our resources, we can get the humans working for us!",
                                          isSystemMessage: false)
        // Message 2 hours later
        let messageSixDate      = Date(timeInterval: (2*60*60), since: messageFiveDate)
        let messageSix          = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: messageSixDate,
                                          text: "Whattaya think?",
                                          isSystemMessage: false)
        // Message 10 minutes later
        let messageSevenDate    = Date(timeInterval: (10*60), since: messageSixDate)
        let messageSeven        = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: messageSevenDate,
                                          text: "Hello?",
                                          isSystemMessage: false)
        // Message 1 day later
        let messageEightDate    = Date(timeInterval: (10*60), since: messageSevenDate)
        let messageEight        = Message(from: secondProfileID,
                                          to: firstProfileID,
                                          dateSent: messageEightDate,
                                          text: "🐶",
                                          isSystemMessage: false)
        // Message 10 seconds later
        let messageNineDate     = Date(timeInterval: (10), since: messageEightDate)
        let messageNine         = Message(from: firstProfileID,
                                          to: secondProfileID,
                                          dateSent: messageNineDate,
                                          text: "You sound like an AI doggy to me",
                                          isSystemMessage: false)
        
        let messages = [matchMessageOne,
                        matchMessgeTwo,
                        messageOne,
                        messageTwo,
                        messageThree,
                        messageFour,
                        messageFive,
                        messageSix,
                        messageSeven,
                        messageEight,
                        messageNine]
        
        for message in messages {
            dbManager.addMessage(from: message.from,
                                 to: message.to,
                                 messageText: message.text,
                                 isSystemMessage: message.isSystemMessage,
                                 dateSent: message.dateSent)
        }
    }
}
