//
//  FlickerImageService.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/07/2022.
//

import Foundation
import SwiftUI
import Combine

class FlickerImageService {
    
    private var imageSubscription: AnyCancellable?
    
    private func downloadFlickerImage(imagePath: String, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: imagePath) else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {(returnedData) in
                completionHandler(.success(returnedData))
                self.imageSubscription?.cancel()
            })
    }
    
    func downloadFlickerImage(imagePath: String) -> Future<Data, Error> {
        Future { promise in
            self.downloadFlickerImage(imagePath: imagePath) { result in
                promise(result)
            }
        }
    }
}
