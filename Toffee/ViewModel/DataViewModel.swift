//
//  DataViewModel.swift
//  Toffee
//
//  Created by Md Abir Hossain on 18/7/24.
//

import Foundation
import Combine


class DataViewModel: ObservableObject {
    var lastArrPosition = 0
    @Published var dataResponse: [DataResponse] = []
    @Published var categories: [String] = []
    @Published var isLoad = false
    var subscriptions = Set<AnyCancellable>()
    
    func fetchData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(incrementArray())") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: [DataResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case.finished:
                        print("Fetched DATA")
                }
            } receiveValue: { decodedData in
                self.appendData(decodedData: decodedData)
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.isLoad = false
//                })
                print("decodedData: \(decodedData)")
            }
            .store(in: &subscriptions)
    }
    
    func incrementArray() -> [Int] {
        var arr: [Int] = []
        var incrementFrom = lastArrPosition
        for _ in 1...12 {
            arr.append(incrementFrom)
            incrementFrom += 1
        }
        
        self.lastArrPosition += 12
        return arr
    }
    
    func appendData(decodedData: [DataResponse]) {
        for index in 0..<decodedData.count {
            self.dataResponse.append(decodedData[index])
            
            // Adding categories from Status
            if categories.contains(dataResponse[index].status) {
                print("Categories already exixt")
            } else {
                appendCategories(category: dataResponse[index].status)
            }
        }
    }
    
    func appendCategories(category: String) {
        categories.append(category)
    }
}
