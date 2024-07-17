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
    @State private var selectedCategory = "All"
    @State private var selectedCategoryIndex = 0
    
    var filteredData: [DataModel] {
        withAnimation {
            if selectedCategory == "All" {
                return dataModel
            } else {
                return dataModel.filter { ($0.catFilterStr).localizedCaseInsensitiveContains(selectedCategory)
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
                    
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(0 ..< filteredData.count, id: \.self) { index in
                                    SeriesCellView(data: filteredData[index], height: geo.size.width / 3.7)
                                        .onTapGesture {
                                            print("Index: \(index), Cat: \(filteredData[index].catFilterStr)")
                                        }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color.black)
                .padding(.top, 1)
            }
        }
        .navigationToolbar(title: "Web Series", isTitle: true, isSearch: true, isNotification: true, isProfile: true)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
    }
    
    @ViewBuilder
    func SeriesCellView(data: DataModel, height: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack(alignment: .center) {
                Image(data.imageName)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .cornerRadius(2)
                    .overlay (
                        VStack(alignment: .center) {
                            Image(systemName: "play.rectangle.on.rectangle")
                                .font(.system(size: 18))
                            
                            Text("\(data.totalEpisode) Episodes")
                                .font(.system(size: 10, weight: .semibold))
                        }
                            .foregroundColor(Color.white)
                            .frame(width: 70)
                            .frame(maxHeight: .infinity)
                            .background(Color.black.opacity(0.4))
                        , alignment: .trailing
                    )
            }
            
            HStack(alignment: .top, spacing: 10) {
                Text(data.title)
                    .font(.system(size: 14, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
//                Spacer(minLength: 5)
                
                Image(systemName: "ellipsis")
                    .font(.system(size: 14, weight: .semibold))
                    .rotationEffect(.degrees(90))
                    .padding(.top, 8)
            }
            .foregroundColor(Color(red: 190/255, green: 214/255, blue: 242/255))
            
            Text("Toffee • \(data.duration)")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 121/255, green: 142/255, blue: 170/255))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ListView()
}
