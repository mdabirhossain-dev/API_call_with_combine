//
//  NavigationBar.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI


struct ToolBarModifier: ViewModifier {
    
    var title: String
    @State var isTitle: Bool
    @State var isSearch: Bool
    @State var isNotification: Bool
    @State var isProfile: Bool
    
    @Environment(\.presentationMode) var presentation
    
    func body(content: Content) -> some View {
        return content
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button{
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
                            .font(.system(size: 18, weight: .semibold))
                    }
                    
                    Text(title)
                        .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
                        .font(.system(size: 18, weight: .semibold))
                        .onTapGesture {
                            presentation.wrappedValue.dismiss()
                        }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        if isSearch {
                            NavigationLink{
                                SearchView()
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .buttonStyle(.plain)
                        }
                        
                        if isNotification {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Image(systemName: "bell")
                                    .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .buttonStyle(.plain)
                        }
                        
                        if isProfile {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Image(systemName: "person.circle")
                                    .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func navigationToolbar(title: String, isTitle: Bool, isSearch: Bool, isNotification: Bool, isProfile: Bool) -> some View {
        return self.modifier(ToolBarModifier(title: title, isTitle: isTitle, isSearch: isSearch, isNotification: isNotification, isProfile: isProfile))
    }
}
