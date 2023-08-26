//
//  Profile.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation
import RealmSwift

class Profile: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var profileImageURLString: String?
    @Persisted var bioText: String
    
    convenience init(name: String, profileImageURLString: String?, bioText: String) {
        self.init()
        self.name                   = name
        self.profileImageURLString  = profileImageURLString
        self.bioText                = bioText
    }
}
