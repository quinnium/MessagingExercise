//
//  MessagingHeaderView.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import SwiftUI

struct MessagingHeaderView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: MessagingHeaderViewModel
    
    init(user: Profile, friend: Profile) {
        _vm = StateObject(wrappedValue: MessagingHeaderViewModel(user: user, friend: friend))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                // Back button
                Button {
                    dismiss()
                } label: {
                    Label("", systemImage: "chevron.left")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                Spacer()
                // Friend Image and name
                VStack {
                    ProfileImageView(profile: vm.friend, size: 50)
                    Text(vm.friend.name)
                        .bold()
                }
                Spacer()
                // Menu button
                Menu {
                    Button {
                        vm.callFriend()
                    } label: {
                        Label("Call \(vm.friend.name)", systemImage: "phone.fill")
                    }
                    Button {
                        vm.videoCallFriend()
                    } label: {
                        Label("Video Call \(vm.friend.name)", systemImage: "video.fill")
                    }
                    Button("Report") { vm.reportFriend() }
                    Button("Block") { vm.blockFriend() }
                } label: {
                    Label("", systemImage: "ellipsis")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 10)
        .background {
            Color(.systemBackground)
        }
    }
}

struct MessagingHeaderView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static var previews: some View {
        MessagingHeaderView(user: mockingService.firstProfile!, friend: mockingService.secondProfile!)
    }
}
