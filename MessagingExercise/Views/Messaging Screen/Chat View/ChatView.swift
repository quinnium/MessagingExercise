//
//  ChatView.swift
//  MessagingExercise
//
//  Created by Quinn on 22/08/2023.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var vm: ChatViewModel
    
    init(user: Profile, friend: Profile) {
        _vm = StateObject(wrappedValue: ChatViewModel(user: user, friend: friend))
    }
    let array = Array(100...200)
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                LazyVStack {
                    if let messages = vm.messages {
                        ForEach(messages) { message in
                            ChatMessageView(message: message,
                                            previousMessageDate: vm.getPreviousMessageDate(for: message),
                                            previousMessageSenderID: vm.getPreviousMessageSenderID(for: message),
                                            user: vm.user)
                            }
                    }
                }
                .rotationEffect(.radians(.pi))
            }
            .rotationEffect(.radians(.pi))
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static var previews: some View {
        ChatView(user: mockingService.firstProfile!, friend: mockingService.secondProfile!)
    }
}
