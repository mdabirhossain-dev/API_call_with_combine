//
//  ContentView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: ListView(), label: {
                Text("Web Series")
            })
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
