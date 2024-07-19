//
//  DataViewModel.swift
//  Toffee
//
//  Created by Md Abir Hossain on 18/7/24.
//

import Foundation
import Combine

@Observable
class DataViewModel {
    var lastArrPosition = 0
    var arrData: [DataResponse] = []
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
            }
            .store(in: &subscriptions)
    }
    
    func incrementArray() -> [Int] {
        var arr: [Int] = []
        var incrementFrom = lastArrPosition
        for _ in 0...9 {
            arr.append(incrementFrom)
            incrementFrom += 1
        }
        
        self.lastArrPosition += 10
        return arr
    }
    
    func appendData(decodedData: [DataResponse]) {
        for index in 0...decodedData.count {
            self.arrData.append(decodedData[index])
        }
    }
}
