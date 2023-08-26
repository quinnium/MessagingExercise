//
//  ComposeMessageView.swift
//  MessagingExercise
//
//  Created by Quinn on 26/08/2023.
//

import SwiftUI
import RealmSwift

struct ComposeMessageView: View {
    @StateObject var vm: ComposeMessageViewModel
    
    init(user: Profile, friend: Profile) {
        _vm = StateObject(wrappedValue: ComposeMessageViewModel(user: user, friend: friend))
    }
    
    var body: some View {
        HStack {
            TextField("Message", text: $vm.messageText, axis: .vertical)
                .lineLimit(6)
                .padding(.vertical, 8)
                .padding(.leading, 15)

            if !vm.messageText.isEmpty {
                Button {
                    vm.sendMessageResponse()
                    vm.messageText = ""
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.mePink)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 15)
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.gray, lineWidth: 1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background {
            Color.systemBackground
        }
    }
}

struct ComposeMessageView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static var previews: some View {
        ComposeMessageView(user: mockingService.firstProfile!, friend: mockingService.secondProfile!)
    }
}
