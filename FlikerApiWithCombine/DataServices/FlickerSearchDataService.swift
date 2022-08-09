//
//  FlickerSearchDataService.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation
import Combine

class FlickerSearchDataService {
    
    @Published var flikerItems: [FlickerItem] = []
    var flickerSearchSubscription: AnyCancellable?
    
    init() {
        
    }
    
    func getItems(searchKeyword: String, perPage: Int, page: Int) {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=7ae5dd61ab369ce45e5cba1f5e947059&text=\(searchKeyword)&per_page=\(perPage)&page=\(page)&format=json&nojsoncallback=1") else { return }
        
        flickerSearchSubscription = NetworkingManager.download(url: url)
            .decode(type: FlickerResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedResponse) in
                guard let responsePage = returnedResponse.photos?.page,
                      responsePage > 1 else {
                    self?.flikerItems = returnedResponse.photos?.photo ?? []
                    self?.flickerSearchSubscription?.cancel()
                    return
                }
                self?.flikerItems.append(contentsOf: returnedResponse.photos?.photo ?? [])
                self?.flickerSearchSubscription?.cancel()
            })
    }
    
}
