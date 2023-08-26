//
//  MessagingView.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import SwiftUI
import RealmSwift

struct MessagingView: View {
    
    @StateObject var vm: MessagingViewModel
    
    init(user: Profile, friend: Profile) {
        _vm = StateObject(wrappedValue: MessagingViewModel(user: user, friend: friend))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            MessagingHeaderView(user: vm.user, friend: vm.friend)
            SectionSelectionView(selectedSection: $vm.selectedSection)
            
            if vm.selectedSection == .chat {
                VStack(spacing: 0) {
                    ChatView(user: vm.user, friend: vm.friend)
                    ComposeMessageView(user: vm.user, friend: vm.friend)
                }
                .transition(.move(edge: .leading))
            } else if (vm.selectedSection == .profile) {
                ProfileView(profile: vm.friend)
                    .transition(.move(edge: .trailing))
            }
        }
        .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local).onEnded({ value in
            print(value.translation.width)
            if value.translation.width < 0 {
                withAnimation {
                    vm.selectedSection = .profile
                }
            }
            if value.translation.width > 0 {
                withAnimation {
                    vm.selectedSection = .chat
                }
            }
            
        }))
        .toolbar(.hidden)
    }
}

struct MessagingContentView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static var previews: some View {
        MessagingView(user: mockingService.firstProfile!, friend: mockingService.secondProfile!)
            .onAppear() {
                DatabaseManager().printRealmFilePath()
            }
    }
}
