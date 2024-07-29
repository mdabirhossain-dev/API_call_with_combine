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
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.system(size: 14))
            .frame(width: 150, height: 36, alignment: .leading)
            .padding(.leading)
            .background(configuration.isPressed ? Color.white.opacity(0.7) : Color.gray)
    }
}
