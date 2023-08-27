//
//  StringExtensionTests.swift
//  StringExtensionTests
//
//  Created by Quinn on 21/08/2023.
//

import XCTest
@testable import MessagingExercise

final class StringExtensionTests: XCTestCase {

    func testEmojiCorrectlyIdentified() {
        let emojis = ["✅", "⚠️", "😳", "🥐", "🇳🇵", "❓"]
        for emoji in emojis {
            XCTAssertTrue(emoji.containsEmoji)
        }
    }

    func testEmojiNotFalselyIdentified() {
        let textualString = "This is a normal text string with symbols:/'@|\"+=!£$%^&*()áëùœæ"
        XCTAssertFalse(textualString.containsEmoji)
    }
    
    func testThreeEmojiAndNoTextCorrectlyIdentified() {
        let stringOne = "🎈🦶👍🏻"
        XCTAssertTrue(stringOne.containsNoTextAndUpToThreeEmojis)
        
        let stringTwo = "🥶👩‍👧‍👦L"
        XCTAssertFalse(stringTwo.containsNoTextAndUpToThreeEmojis)
        
        let stringThree = "🐞🍙📅🃒"
        XCTAssertFalse(stringThree.containsNoTextAndUpToThreeEmojis)
    }

}
