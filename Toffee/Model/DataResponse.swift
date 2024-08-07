//
//  DataResponse.swift
//  Toffee
//
//  Created by Md Abir Hossain on 17/7/24.
//

import Foundation



struct DataResponse: Decodable, Equatable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


struct Location: Decodable, Equatable {
    let name: String
    let url: String
}

//struct DataModel: Equatable {
//    let id = UUID()
//    let title: String
//    let imageName: String
//    let catFilterStr: String
//    let videoURL: String
//    let duration: String
//    let totalEpisode: String
//}
//
//var dataModel: [DataModel] = [
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img18", catFilterStr: "Thriller", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "60"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img1", catFilterStr: "Comedy", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img2", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img3", catFilterStr: "Drama", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "33"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img4", catFilterStr: "Action", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "59"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img5", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img6", catFilterStr: "Drama", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "25"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img7", catFilterStr: "Thriller", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "46"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img8", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "30"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img9", catFilterStr: "Thriller", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "90"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img10", catFilterStr: "Drama", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img11", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img12", catFilterStr: "Action", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "40"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img13", catFilterStr: "Thriller", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "21"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img14", catFilterStr: "Comedy", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "44"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img15", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "11"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img16", catFilterStr: "Horror", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "29"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img17", catFilterStr: "Action", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "10"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img0", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "22"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img19", catFilterStr: "Horror", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img20", catFilterStr: "Romance", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "26"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img21", catFilterStr: "Action", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img22", catFilterStr: "Comedy", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "80"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img23", catFilterStr: "Thriller", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "56"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img24", catFilterStr: "Comedy", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "67"),
//    DataModel(title: "Sapien urna cum hac portitor netus e eges otog khuj kgumo", imageName: "img25", catFilterStr: "Action", videoURL: "https://mdabirhossain.com/", duration: "13h", totalEpisode: "17")
//]
