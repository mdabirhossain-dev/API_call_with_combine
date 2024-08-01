//
//  MenuButtonStyle.swift
//  Toffee
//
//  Created by Md Abir Hossain on 29/7/24.
//

import SwiftUI

struct MenuButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(title, action: {
            action()
        })
        .buttonStyle(MenuButtonStyle())
    }
}

#Preview {
    MenuButton(title: "Button Title", action: {
        print("Do execution")
    })
}

struct MenuButtonStyle: ButtonStyle {
    
    var menuWdith: CGFloat  =  140
    var buttonHeight: CGFloat  =  36
    let backgroundColor = Color(red: 41/255, green: 70/255, blue: 107/255)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.system(size: 12))
//            .frame(width: 150, height: 36, alignment: .leading)
//            .padding(.leading)
            .padding(.horizontal, 14)
            .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
            .background(configuration.isPressed ? .white.opacity(0.2) : backgroundColor)
    }
}
