//
//  ChatMessageView.swift
//  MessagingExercise
//
//  Created by Quinn on 22/08/2023.
//

import SwiftUI
import RealmSwift

struct ChatMessageView: View {
    
    @StateObject var vm: ChatMessageViewModel
    
    init(message: Message, previousMessageDate: Date?, previousMessageSenderID: ObjectId?, user: Profile) {
        _vm = StateObject(wrappedValue: ChatMessageViewModel(message: message, previousMessageDate: previousMessageDate, previousMessageSenderID: previousMessageSenderID, user: user))
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: vm.messageHeaderHeight)
            if vm.displayDateStamp {
                // Date stamp
                HStack {
                    Text(vm.messageDate)
                        .bold()
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text(vm.timeString)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            // If System Messge
            if vm.isSystemMessage {
                Text(vm.messageText)
                    .font(Font.custom("Didot", size: 22))
                    .bold()
                    .padding(.vertical, 10)
            } else {
                // Normal message
                ZStack(alignment: .bottomTrailing) {
                    Text(vm.messageText)
                        .font(vm.isEmojiMessage ? .system(size: 45) : .body)
                        .textSelection(.enabled)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 16)
                        .background {
                            if !vm.isEmojiMessage {
                                vm.sentByUser ? Color.mePink : .lightGray
                            }
                        }
                        .cornerRadius(15, corners: [.topLeft, .topRight, vm.sentByUser ? .bottomLeft : .bottomRight])
                        .frame(maxWidth: 275, alignment: vm.sentByUser ? .trailing : .leading)
                    // Message status indicator
                    if vm.sentByUser {
                        vm.messageStatusImage
                            .resizable()
                            .scaledToFit()
                            .frame(height: 7)
                            .offset(x: -4, y: -4)
                    }
                }
                .frame(maxWidth: .infinity, alignment: vm.sentByUser ? .trailing : .leading)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static let message = Message(from: mockingService.firstProfile!.id,
                                 to: mockingService.firstProfile!.id,
                                 dateSent: Date.distantPast,
                                 text: "You are friends",
                                 isSystemMessage: false)
    static var previews: some View {
        ChatMessageView(message: message, previousMessageDate: nil, previousMessageSenderID: nil, user: mockingService.secondProfile!)
    }
}
