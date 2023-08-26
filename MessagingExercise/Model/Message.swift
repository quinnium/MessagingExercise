//
//  Message.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation
import RealmSwift

class Message: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var from: ObjectId
    @Persisted var to: ObjectId
    @Persisted var dateSent: Date
    @Persisted var text: String
    @Persisted var isSystemMessage: Bool
    
    convenience init(from: ObjectId, to: ObjectId, dateSent: Date, text: String, isSystemMessage: Bool) {
        self.init()
        self.from               = from
        self.to                 = to
        self.dateSent           = dateSent
        self.text               = text
        self.isSystemMessage    = isSystemMessage
    }
}
