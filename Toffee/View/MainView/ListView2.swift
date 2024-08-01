//
//  ListView2.swift
//  Toffee
//
//  Created by Md Abir Hossain on 29/7/24.
//

import SwiftUI

struct ListView2: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @EnvironmentObject var dataVM: DataViewModel
    @State private var selectedCategory = "All"
    @State private var selectedCategoryIndex = 0
    @State private var dataResponse: [DataResponse] = []
    @State private var isHide = true
    
    @State private var scrollToTop = false
    
//    @State private  var hideDropdown = true
    
    var filteredData: [DataResponse] {
        withAnimation {
            if selectedCategory == "All" {
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
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                /// Infinity Scroll...
                                if dataVM.offset == dataVM.dataResponse.count {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                                        .scaleEffect(2)
                                        .padding(.vertical)
                                        .onAppear(perform: {
                                            print("Fetch Data from (BOTTOM SWIPE)")
                                            dataVM.isLoad = true
                                            dataVM.fetchData()
                                            print("GROD")
                                        })
                                } else {
                                    GeometryReader { reader -> Color in
                                        let minY = reader.frame(in: .global).minY
                                        
                                        let height = UIScreen.main.bounds.height / 1.3
                                        
                                        if !dataVM.dataResponse.isEmpty && minY < height {
                                            
                                            print("Last data...")
                                            
                                            DispatchQueue.main.async {
                                                dataVM.offset = dataVM.dataResponse.count
                                            }
                                        }
                                        
                                        return Color.clear
                                    }
                                    .frame(width: 20, height: 20)
                                }
                            }
                        }
                    }
                }
                .background(Color.black)
                .padding(.top, 1)
                
//                if dataVM.isLoad {
//                    Color.black.opacity(0.5).ignoresSafeArea(edges: .all)
//                    
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: Color.red))
//                        .scaleEffect(4)
//                }
                
                if DropDown.shared.showDropdown {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
//                            hideDropdown = true
                            DropDown.shared.showDropdown = false
                            NotificationCenter.default.post(name: .menuNotification, object: nil, userInfo: ["status" : false])
//                            print("1showDropdown: \(hideDropdown)")
                        }
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
    ListView2()
}


class DropDown: ObservableObject {
    static let shared = DropDown()
    @Published var showDropdown = true
}
