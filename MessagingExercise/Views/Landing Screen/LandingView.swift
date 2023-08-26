//
//  LandingView.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import SwiftUI

struct LandingView: View {
    
    @StateObject var vm = LandingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
            
                VStack(spacing: 50) {
                    NavigationLink(value: vm.profileOne) {
                        MEButton(title: "Enter as Profile 1", color: vm.profilesExist ? .red : .gray, width: 250, height: 60)
                    }
                    .disabled(!vm.profilesExist)
                    
                    NavigationLink(value: vm.profileTwo) {
                        MEButton(title: "Enter as Profile 2", color: vm.profilesExist ? .blue : .gray, width: 250, height: 60)
                    }
                    .disabled(!vm.profilesExist)
                }
                
                Spacer()
                    .frame(height: 50)
                
                VStack(spacing: 20) {
                    Button(action: {
                        vm.generateMockProfiles()
                    }, label: {
                        MEButton(title: "Generate Profiles", color: vm.profilesExist ? .gray : .green, fill: false, textColor: vm.profilesExist ? .gray : .green, width: 200, height: 40)
                    })
                    .disabled(vm.profilesExist)
                    
                    Button(action: {
                        vm.generateMockMessages()
                    }, label: {
                        MEButton(title: "Mock Messages", color: vm.profilesExist ? .green : .gray, fill: false, textColor: vm.profilesExist ? .green : .gray, width: 200, height: 40)
                    })
                    .disabled(!vm.profilesExist)
                    
                    Button(action: {
                        vm.deleteAllMessages()
                    }, label: {
                        MEButton(title: "Delete All Messages", color: .red, fill: false, textColor: .red, width: 200, height: 40)
                    })
                    
                }
                
            }
            .navigationDestination(for: Profile.self) { profile in
                if let friend = vm.getCorrespondingFriend(for: profile) {
                    MessagingView(user: profile, friend: friend)
                }
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
