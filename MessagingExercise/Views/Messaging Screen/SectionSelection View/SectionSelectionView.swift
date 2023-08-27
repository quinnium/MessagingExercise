//
//  SectionSelectionView.swift
//  MessagingExercise
//
//  Created by Quinn on 22/08/2023.
//

import SwiftUI

struct SectionSelectionView: View {
    
    @Binding var selectedSection: MessagingSectionOptions
    
    var body: some View {
        
        // Chat / Profile tab selection
        HStack(spacing: 0) {
            
            // Chat button
            Button("Chat") {
                withAnimation { selectedSection = .chat }
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
            .foregroundColor(selectedSection == .chat ? Color.mePink : .gray)
            .padding(.vertical, 10)
            
            
            // Pink 'Underline' below 'Chat' tab
            .overlay(alignment: .bottom, content: {
                Rectangle()
                    .fill(selectedSection == .chat ? Color.mePink : .clear)
                    .frame(height: 3)
            })
            
            // Profile button
            Button("Profile") {
                withAnimation { selectedSection = .profile }
            }
            .foregroundColor(selectedSection == .profile ? Color.mePink : .gray)
            .padding(.vertical, 10)
            
            .padding(.vertical, 0)
            .frame(maxWidth: .greatestFiniteMagnitude)
            
            // Pink 'Underline' below 'Profile' tab
            .overlay(alignment: .bottom, content: {
                Rectangle()
                    .fill(selectedSection == .profile ? Color.mePink : .clear)
                    .frame(height: 3)
            })
        }
        .bold()
        .background(Color.systemBackground)
    }
}

struct SectionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionSelectionView(selectedSection: .constant(.chat))
    }
}
