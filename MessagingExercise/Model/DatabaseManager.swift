//
//  DatabaseManager.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import Foundation
import RealmSwift

protocol DatabaseResultsChangedProtocol {
    func resultsChanged(deletions: [Int], insertions: [Int], modifications: [Int])
}

final class DatabaseManager {
    
    let realm: Realm
    let configurationPathName = "MEQuinnium"
    var notificationToken: NotificationToken?
    var delegate: DatabaseResultsChangedProtocol?
    
    init(forTesting: Bool = false) {
        var configuration: Realm.Configuration
        if forTesting {
            configuration = Realm.Configuration(inMemoryIdentifier: "MEQuinnium")
        } else {
            configuration = Realm.Configuration.defaultConfiguration
            if configuration.fileURL != nil {
                configuration.fileURL!.deleteLastPathComponent()
                configuration.fileURL!.append(path: configurationPathName)
                configuration.fileURL!.appendPathExtension("realm")
            }
        }
        do {
            realm = try Realm(configuration: configuration)
        } catch {
            fatalError("failed to load Realm with configuration \(error)")
        }
    }
    
    deinit {
    print("Log: databseManager instance deinitialised")
        notificationToken?.invalidate()
    }

    func printRealmFilePath() {
        let path = realm.configuration.fileURL
        print("Log: Realm database at: \(path?.description ?? "not found")")
    }
    
    func addProfile(name: String, imageURLString: String, bioText: String) {
        realm.beginWrite()
        let profile = Profile(name: name, profileImageURLString: imageURLString, bioText: bioText)
        realm.add(profile)
        commitChanges()
    }
    
    func fetchProfileForName(name: String) -> Profile? {
        let results = realm.objects(Profile.self).filter { $0.name == name }
        guard results.count > 0 else { return nil }
        return results.first!
    }
    
    func fetchProfile(withId id: ObjectId) -> Profile? {
        return realm.object(ofType: Profile.self, forPrimaryKey: id)
    }
    
    func addMessage(from sender: ObjectId, to recipient: ObjectId, messageText: String, isSystemMessage: Bool, dateSent: Date = Date()) {
        realm.beginWrite()
        let message = Message(from: sender, to: recipient, dateSent: dateSent, text: messageText, isSystemMessage: isSystemMessage)
        realm.add(message)
        commitChanges()
    }
    
    func getMessagesBetween(profileOne: ObjectId, profileTwo: ObjectId) -> Results<Message> {
        let messages = realm.objects(Message.self).where {
            ($0.from == profileOne && $0.to == profileTwo && $0.isSystemMessage == false) ||
            ($0.from == profileTwo && $0.to == profileOne && $0.isSystemMessage == false) ||
            ($0.from == profileTwo && $0.to == profileOne && $0.isSystemMessage == true) }
        
        notificationToken = messages.observe { [weak self] change in
            DispatchQueue.main.async {
                switch change {
                    case .initial(_):
                        break
                    case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                        self?.delegate?.resultsChanged(deletions: deletions, insertions: insertions, modifications: modifications)
                    case .error(let error):
                        print(error.localizedDescription)
                }
            }
        }
        return messages.sorted(byKeyPath: "dateSent", ascending: true)
    }
    
    func deleteAllmessagesInMemory() {
        realm.beginWrite()
        realm.delete(realm.objects(Message.self))
        commitChanges()
    }
  
    private func commitChanges() {
        do {
            try realm.commitWrite()
        } catch {
            print("Failed to commit changes to database: \(error)")
        }
    }
}
