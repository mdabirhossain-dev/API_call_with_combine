//
//  ContentView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var dataVM = DataViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: ListView().environmentObject(dataVM), label: {
                    Text("Reach bottom to load")
                })
                NavigationLink(destination: ListView2().environmentObject(dataVM), label: {
                    Text("Swipe up to load")
                })
            }
            .font(.title)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
