//
//  ChatMessageViewModel.swift
//  MessagingExercise
//
//  Created by Quinn on 22/08/2023.
//

import Foundation
import SwiftUI
import RealmSwift

class ChatMessageViewModel: ObservableObject {
    
    private let message: Message
    private let previousMessageDate: Date?
    private let previousMessageSenderID: ObjectId?
    private let user: Profile
    
    init(message: Message, previousMessageDate: Date?, previousMessageSenderID: ObjectId?, user: Profile) {
        self.message                    = message
        self.previousMessageDate        = previousMessageDate
        self.previousMessageSenderID    = previousMessageSenderID
        self.user                       = user
    }
    
    var messageHeaderHeight: CGFloat {
        if displayDateStamp { return 10 }
        // If previous previous message was from same sender AND within 20 seconds ago, then reduce the spacing between them
        if  previousMessageDate != nil &&
            previousMessageSenderID == message.from &&
            message.dateSent.timeIntervalSinceNow < (previousMessageDate!.timeIntervalSinceNow + 20) {
            
            return 2
        }
        return 20
    }
    
    var displayDateStamp: Bool {
        // Display Date Stamp if there has been no previous message, or message sent an hour after last message
        if previousMessageDate == nil ||
                message.dateSent.timeIntervalSinceNow > (previousMessageDate!.timeIntervalSinceNow + (60*60)) {
            return true
        } else {
            return false
        }  
    }
    
    var messageDate: String {
        if Calendar.autoupdatingCurrent.isDateInToday(message.dateSent) {
            return "Today"
        } else if Calendar.autoupdatingCurrent.isDateInYesterday(message.dateSent) {
            return "Yesterday"
        } else {
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "MMMM dd, yyyy"
            return dateFormatter.string(from: message.dateSent)
        }
    }
    
    var timeString: String {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: message.dateSent)
    }
    
    var isSystemMessage: Bool {
        message.isSystemMessage
    }
    
    var messageText: String {
        message.text
    }
    
    var sentByUser: Bool {
        message.from == user.id
    }
    
    var isEmojiMessage: Bool {
        message.text.containsNoTextAndUpToThreeEmojis
    }
    
    var messageStatusImage: Image {
        // Mocked as assumed as having been 'received', so always displays double tick
        // Message status image needs to be in different colour depending on whether or not message is within a chat bubble
        if isEmojiMessage {
            return Image(Constants.ImageResourceStrings.doubleCheckRed)
        } else {
            return Image(Constants.ImageResourceStrings.doubleCheckWhite)
        }
    }
}
