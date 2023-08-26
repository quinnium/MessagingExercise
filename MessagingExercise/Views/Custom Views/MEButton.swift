//
//  MEButton.swift
//  MessagingExercise
//
//  Created by Quinn on 21/08/2023.
//

import SwiftUI

struct MEButton: View {
    let title: String
    let color: Color
    let fill: Bool
    let textColor: Color
    let width: CGFloat
    let height: CGFloat
    
    init(title: String, color: Color, fill: Bool = true, textColor: Color = .white, width: CGFloat, height: CGFloat) {
        self.title      = title
        self.color      = color
        self.fill       = fill
        self.textColor  = textColor
        self.width      = width
        self.height     = height
    }
    
    var body: some View {
        Text(title)
            .bold()
            .frame(width: width, height: height)
            .foregroundColor(textColor)
            .background(fill ? color : .clear)
            .cornerRadius(10)
            .overlay {
                if fill != true {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(color)
                }
            }
    }
}


struct MEButton_Previews: PreviewProvider {
    static var previews: some View {
        MEButton(title: "This is a test", color: .purple, fill: false, textColor: .purple, width: 250, height: 60)
    }
}
