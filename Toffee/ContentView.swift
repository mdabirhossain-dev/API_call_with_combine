//
//  ContentView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var dataVM = DataViewModel()
    
    let fruits = ["apple", "banana", "orange", "kiwi"]
    @State  private  var selectedOptionIndex =  0
    @State  private  var showDropdown =  false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: ListView().environmentObject(dataVM), label: {
                    Text("Reach bottom to load")
                })
                NavigationLink(destination: ListView2().environmentObject(dataVM), label: {
                    Text("Swipe up to load")
                })
                
                DropDownMenu(dataName: "No Name", showDropdown: $showDropdown)
                
                
                
                DropDownMenu(dataName: "No Name", showDropdown: $showDropdown)
                    .padding(.top, 40)
            }
            .font(.title)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
