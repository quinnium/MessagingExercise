//
//  String+Ext.swift
//  MessagingExercise
//
//  Created by Quinn on 22/08/2023.
//

import Foundation

extension String {
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x1F1E6...0x1F1FF, // Regional country flags
                 0x2600...0x26FF,   // Misc symbols
                 0x2700...0x27BF,   // Dingbats
                 0xE0020...0xE007F, // Tags
                 0xFE00...0xFE0F,   // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 0x1F018...0x1F270, // Various asian characters
                 0x238C...0x2454,   // Misc items
                 0x20D0...0x20FF:   // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    var containsNoTextAndUpToThreeEmojis: Bool {
        let arrayOfCharacters   = Array(self)
        var emojiCount          = 0
        for element in arrayOfCharacters {
            if element.description.containsEmoji {
                emojiCount += 1
            } else {
                return false
            }
        }
        if emojiCount < 4 {
            return true
        } else {
            return false
        }
    }
}
