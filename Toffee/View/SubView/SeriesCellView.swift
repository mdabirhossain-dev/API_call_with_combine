//
//  SeriesCellView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 24/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeriesCellView: View {
    
    @EnvironmentObject var dataVM: DataViewModel
    let data: DataResponse
    let height: CGFloat
    @State private var isLoadSuccess = true
    @State private var noImage = UIImage(named: "noImage")
    
    @State private var showDropdown = false
//    @Binding var hideDropdown: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
                WebImage(url: URL(string: data.image)) { image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .cornerRadius(2)
                        .overlay (
                            VStack(alignment: .center, spacing: 8) {
                                Image(systemName: "play.rectangle.on.rectangle")
                                    .font(.system(size: 18))
                                
                                Text("56 Episodes")
                                    .font(.system(size: 10, weight: .semibold))
                                    .multilineTextAlignment(.center)
                            }
                                .foregroundColor(Color.white)
                                .frame(width: height / 1.6)
                                .frame(maxHeight: .infinity)
                                .background(Color.black.opacity(0.4))
                            , alignment: .trailing
                        )
                } placeholder: {
                    if isLoadSuccess {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
                            .scaleEffect(1.5)
                            .frame(maxWidth: .infinity)
                            .frame(height: height)
                    } else {
                        Image(uiImage: noImage!)
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: height)
                            .cornerRadius(2)
                    }
                }
                .onFailure { _ in
                    isLoadSuccess = false
                }
                
                
//                Color.black.opacity(0.8)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        showDropdown = false
//                        print("showDropdown: \(showDropdown)")
//                    }
            }
            
//            HStack(alignment: .top, spacing: 10) {
//                Text(data.name)
//                    .font(.system(size: 14, weight: .semibold))
//                    .lineLimit(2)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                Menu {
//                    ShareLink(item: URL(string: data.image) ?? URL(string: "https://viterbischool.usc.edu/wp-content/uploads/2023/10/404.jpg")!) {
//                        Label("Share to Others", systemImage: "square.and.arrow.up")
//                    }
//                    
//                    Button {
//                        print("Save button tapped...")
//                    } label: {
//                        Label("Save to Favourite", systemImage: "sdcard")
//                    }
//                    
//                    Button {
//                        withAnimation {
//                            if let index = self.dataVM.dataResponse.firstIndex(of: data) {
//                                self.dataVM.dataResponse.remove(at: index)
//                            }
//                        }
//                        
//                        print("Delete button tapped...")
//                    } label: {
//                        Label("Delete from List", systemImage: "trash")
//                    }
//                } label: {
//                    Image(systemName: "ellipsis")
//                        .font(.system(size: 14, weight: .semibold))
//                        .rotationEffect(.degrees(90))
//                        .padding(8)
//                }
            
            DropDownMenu(dataName: data.name, showDropdown: $showDropdown)
            
//            }
//            .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
//            .padding(.top, 5)
            
            Text("Toffee • 2h")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 121/255, green: 142/255, blue: 170/255))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer() // for TOP alignment
        }
//        .onChange(of: DropDown.shared.hideDropdown, perform: { _ in
//            if DropDown.shared.hideDropdown {
//                showDropdown = false
//                print("onChange:showDropdown: \(showDropdown)")
//            }
//            DropDown.shared.hideDropdown = false
//        })
    }
}

