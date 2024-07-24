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
    @State private var selectedCategory = "All"
    @State private var selectedCategoryIndex = 0
    @State private var dataResponse: [DataResponse] = []
    @State private var isHide = true
    
    var filteredData: [DataResponse] {
        withAnimation {
            if selectedCategory == "All" {
                return dataResponse
            } else {
                return dataResponse.filter { ($0.status).localizedCaseInsensitiveContains(selectedCategory)
                }
            }
        }
    }
    
    @State private var readToEnd = false
    @State private var scrollViewHeight = CGFloat.infinity
    
    @Namespace private var scrollViewNameSpace
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(red: 17/255, green: 31/255, blue: 49/255)
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0 ..< categories.count, id: \.self) { index in
                                Button(categories[index]) {
                                    print("Selected cat: \(categories[index])")
                                    withAnimation {
                                        selectedCategory = categories[index]
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
                                ForEach(0 ..< dataVM.dataResponse.count, id: \.self) { index in
                                    SeriesCellView(data: dataVM.dataResponse[index], height: geo.size.width / 3.7)
                                        .onTapGesture {
                                            print("Index: \(index),\nCat\(dataVM.dataResponse.count): \(dataVM.dataResponse[index])")
                                        }
                                        .onAppear(perform: {
                                            if index + 1 == dataVM.dataResponse.count {
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
            .onChange(of: dataVM.dataResponse) { _ in
                dataResponse = dataVM.dataResponse
            }
            .onAppear(perform: {
                dataVM.fetchData()
            })
        }
        .navigationToolbar(title: "Web Series", isTitle: true, isSearch: true, isNotification: true, isProfile: true)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
    }
    
    @ViewBuilder
    func SeriesCellView(data: DataResponse, height: CGFloat) -> some View {
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
                    Image("noImage")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .cornerRadius(2)
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
                        
                        isHide.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0009) {
                            isHide.toggle()
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

#Preview {
    ListView()
}
