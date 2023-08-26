//
//  ProfileView.swift
//  MessagingExercise
//
//  Created by Quinn on 26/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm: ProfileViewModel
    
    init(profile: Profile) {
        _vm = StateObject(wrappedValue: ProfileViewModel(profile: profile))
    }
    
    var body: some View {
        VStack {
            Spacer()
            ProfileImageView(profile: vm.profile, size: 150)
                .padding(.vertical, 20)
            Text(vm.profile.bioText)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background {
            Color.systemBackground
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static var previews: some View {
        ProfileView(profile: mockingService.secondProfile!)
    }
}
