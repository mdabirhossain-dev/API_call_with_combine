//
//  DropdownView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 1/8/24.
//

import SwiftUI

struct  DropDownMenu: View {
    
    var maxItemDisplayed: Int  =  5
    
    let dataName: String?
    @Binding  var showDropdown: Bool
    
    @State  private  var scrollPosition: Int?
    
    var body: some  View {
        VStack {
            VStack(spacing: 0) {
                if (showDropdown) {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        Button("Add to Favourite") {
                            print("Tapped to Favourite...drop: \(showDropdown)")
                            withAnimation {
                                showDropdown.toggle()
                            }
                            print("Tapped to Favourite...drop: \(showDropdown)")
                        }
                        .buttonStyle(MenuButtonStyle())
                        
                        Button("Add to Playlist") {
                            print("Tapped to Playlist...drop: \(showDropdown)")
                            withAnimation {
                                showDropdown.toggle()
                            }
                        }
                        .buttonStyle(MenuButtonStyle())
                        
                        Button("Report") {
                            print("Tapped to Report...drop: \(showDropdown)")
                            withAnimation {
                                showDropdown.toggle()
                            }
                        }
                        .buttonStyle(MenuButtonStyle())
                    }
                    .background(Color(red: 41/255, green: 70/255, blue: 107/255))
                }
                
                // selected item
                HStack(alignment: .top, spacing: 10) {
                    Text(dataName ?? "No Name")
                        .font(.system(size: 14, weight: .semibold))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            showDropdown.toggle()
                        }
                        DropDown.shared.showDropdown = true
//                        NotificationCenter.default.post(name: .menuNotification, object: nil, userInfo: ["status" : false])
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .rotationEffect(.degrees(90))
                            .padding(8)
                    })
                }
            }
        }
        .frame(width: 140, height: 36, alignment: .bottom)
        .zIndex(100)
        
        .onReceive(NotificationCenter.default.publisher(for: .menuNotification)) { notification in
            if let status = notification.userInfo?["status"] as? Bool {
                if !status {
                    showDropdown = status
                    DropDown.shared.showDropdown = status
                }
                print("1showDropdown: \(showDropdown)")
            }
        }
    }
}
