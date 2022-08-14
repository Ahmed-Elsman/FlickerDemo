//
//  FlickerSearchDataService.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation
import Combine

class FlickerSearchDataService {
    
    var flickerSearchSubscription: AnyCancellable?
    
    private func getItems(searchKeyword: String, perPage: Int, page: Int, completionHandler: @escaping (Result<[FlickerItem], Error>) -> ()) {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=7ae5dd61ab369ce45e5cba1f5e947059&text=\(searchKeyword)&per_page=\(perPage)&page=\(page)&format=json&nojsoncallback=1") else { return }
        
        flickerSearchSubscription = NetworkingManager.download(url: url)
            .decode(type: FlickerResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedResponse) in
                completionHandler(.success(returnedResponse.photos?.photo ?? []))
                self?.flickerSearchSubscription?.cancel()
            })
    }
    
    func getItems(searchKeyword: String, perPage: Int, page: Int) -> Future<[FlickerItem], Error> {
        Future { promise in
            self.getItems(searchKeyword: searchKeyword, perPage: perPage, page: page) { result in
                promise(result)
            }
        }
    }
}
