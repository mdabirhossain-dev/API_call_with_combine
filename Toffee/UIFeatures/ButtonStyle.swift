//
//  ButtonStyle.swift
//  Toffee
//
//  Created by Md Abir Hossain on 17/7/24.
//

import SwiftUI

struct CategoryButtonStyle: ButtonStyle {
    let isSelected: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(height: 30)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .padding(.bottom, 3)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 41/255, green: 70/255, blue: 107/255), lineWidth: 3)
            )
            .background(
                isSelected ? Color(red: 41/255, green: 70/255, blue: 107/255) : Color.clear
            )
            .cornerRadius(20)
    }
}
