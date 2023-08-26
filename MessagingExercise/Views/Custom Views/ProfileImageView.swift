//
//  ProfileImageView.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import SwiftUI
import RealmSwift

struct ProfileImageView: View {
    
    let profile: Profile
    let size: CGFloat
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: profile.profileImageURLString ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image("blank")
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static let mockingService = MockingService()
    static var previews: some View {
        ProfileImageView(profile: mockingService.firstProfile!, size: 100)
    }
}
