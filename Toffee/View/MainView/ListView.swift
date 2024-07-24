//
//  ListView.swift
//  Toffee
//
//  Created by Md Abir Hossain on 16/7/24.
//

import SwiftUI

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
    
//    @State private var scrollViewProxy: ScrollViewProxy = .scrollTo("0", anchor: .top)
    @State private var scrollToTop = false
    
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
                    ScrollViewReader { reader in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0 ..< dataVM.categories.count, id: \.self) { index in
                                    Button(dataVM.categories[index]) {
                                        print("Selected cat: \(dataVM.categories[index])")
                                        withAnimation {
                                            selectedCategory = dataVM.categories[index]
                                            selectedCategoryIndex = index
                                            
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                                scrollToTop.toggle()
//                                            }
                                        }
                                    }
                                    .buttonStyle(CategoryButtonStyle(isSelected: selectedCategoryIndex == index ? true : false))
                                    .id("\(index)")
                                    
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
                                            .id(index)
                                            .environmentObject(dataVM)
                                            .onTapGesture {
                                                print("Index: \(index),\nCat\(filteredData.count): \(filteredData[index])")
                                            }
                                            .onAppear(perform: {
                                                if isLastCell(index: index) {
                                                    dataVM.isLoad = true
                                                    dataVM.fetchData()
                                                    print("GROD")
                                                }
                                            })
                                    }
                                }
                                .gesture(
                                    DragGesture(minimumDistance: 1.0, coordinateSpace: .local)
                                        .onEnded { value in
                                            print(value.translation)
                                            switch(value.translation.width, value.translation.height) {
                                                case (...0, -30...30):
                                                    print("left swipe")
                                                case (0..., -30...30):
                                                    print("right swipe")
                                                case (-100...100, ...0):
                                                    dataVM.isLoad = true
                                                    dataVM.fetchData()
                                                    print("GROD")
                                                    print("up swipe")
                                                case (-100...100, 0...):
                                                    print("down swipe")
                                                default:  print("no clue")
                                            }
                                        }
                                )
                                .padding(.horizontal, 20)
                                .onChange(of: scrollToTop) { _, _ in
                                    withAnimation {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            reader.scrollTo(1, anchor: .center)
                                            scrollToTop.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 1.0, coordinateSpace: .local)
                        .onEnded { value in
                            print(value.translation)
                            switch(value.translation.width, value.translation.height) {
                                case (...0, -30...30):
                                    print("left swipe")
                                case (0..., -30...30):
                                    print("right swipe")
                                case (-100...100, ...0):
                                    dataVM.isLoad = true
                                    dataVM.fetchData()
                                    print("GROD")
                                    print("up swipe")
                                case (-100...100, 0...):
                                    print("down swipe")
                                default:  print("no clue")
                            }
                        }
                )
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
                dataVM.isLoad = true
                dataVM.fetchData()
            })
        }
        .navigationToolbar(title: "Web Series", isTitle: true, isSearch: true, isNotification: true, isProfile: true)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
    }
    
    func isLastCell(index: Int) -> Bool {
        if index == filteredData.count - 1 {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    ListView()
}
