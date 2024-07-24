//
//  ListView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListView: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    let categories = ["All", "Thriller", "Romance", "Comedy", "Horror", "Drama", "Action"]
    @StateObject var dataVM = DataViewModel()
    @State private var selectedCategory = ""
    @State private var selectedCategoryIndex = 0
    @State private var dataResponse: [DataResponse] = []
    @State private var isHide = true
    
    var filteredData: [DataResponse] {
        withAnimation {
            if selectedCategory == "" {
                return dataVM.dataResponse
            } else {
                return dataVM.dataResponse.filter { ($0.status).localizedCaseInsensitiveContains(selectedCategory)
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(red: 17/255, green: 31/255, blue: 49/255)
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0 ..< dataVM.categories.count, id: \.self) { index in
                                Button(dataVM.categories[index]) {
                                    print("Selected cat: \(dataVM.categories[index])")
                                    withAnimation {
                                        selectedCategory = dataVM.categories[index]
                                        selectedCategoryIndex = index
                                    }
                                }
                                .buttonStyle(CategoryButtonStyle(isSelected: selectedCategoryIndex == index ? true : false))
                                
                            }
                        }
                        .padding([.top, .leading, .bottom], 8)
                    }
                    .background(Color.black)
                    
                    VStack(alignment: .center) {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0 ..< filteredData.count, id: \.self) { index in
                                    SeriesCellView(data: filteredData[index], height: geo.size.width / 3.7)
                                        .environmentObject(dataVM)
                                        .onTapGesture {
                                            print("Index: \(index),\nCat\(filteredData.count): \(filteredData[index])")
                                        }
                                        .onAppear(perform: {
                                            if index + 1 == filteredData.count {
                                                dataVM.isLoad = true
                                                dataVM.fetchData()
                                                print("GROD")
                                            }
                                        })
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color.black)
                .padding(.top, 1)
                
                if dataVM.isLoad {
                    Color.black.opacity(0.5).ignoresSafeArea(edges: .all)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
                        .scaleEffect(4)
                }
            }
            .onAppear(perform: {
                dataVM.fetchData()
            })
        }
        .navigationToolbar(title: "Web Series", isTitle: true, isSearch: true, isNotification: true, isProfile: true)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
    }
}

#Preview {
    ListView()
}


struct SeriesCellView: View {
    
    @EnvironmentObject var dataVM: DataViewModel
    let data: DataResponse
    let height: CGFloat
    @State private var isLoadSuccess = true
    @State private var noImage = UIImage(named: "noImage")
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
//                Image(data.image)
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
            }
            
            HStack(alignment: .top, spacing: 10) {
                Text(data.name)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Menu {
                    ShareLink(item: URL(string: data.image) ?? URL(string: "https://viterbischool.usc.edu/wp-content/uploads/2023/10/404.jpg")!) {
                        Label("Share to Others", systemImage: "square.and.arrow.up")
                    }
                    
                    Button {
                        print("Save button tapped...")
                    } label: {
                        Label("Save to Favourite", systemImage: "sdcard")
                    }
                    
                    Button {
                        if let index = self.dataVM.dataResponse.firstIndex(of: data) {
                            self.dataVM.dataResponse.remove(at: index)
                        }
                        
                        print("Delete button tapped...")
                    } label: {
                        Label("Delete from List", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 14, weight: .semibold))
                        .rotationEffect(.degrees(90))
                        .padding(8)
                }
            }
            .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
            .padding(.top, 5)
            
            Text("Toffee • 2h")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 121/255, green: 142/255, blue: 170/255))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer() // for alignment issue
        }
    }
}
