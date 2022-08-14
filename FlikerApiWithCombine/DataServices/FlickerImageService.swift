//
//  FlickerImageService.swift
//  SwiftfulCrypto
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation
import SwiftUI
import Combine

class FlickerImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let flickerItem: FlickerItem
    
    init(flickerItem: FlickerItem) {
        self.flickerItem = flickerItem
        getFlickerImage()
    }
    
    private func getFlickerImage() {
        downloadFlickerImage()
    }
    
    private func downloadFlickerImage() {
        guard let url = URL(string: flickerItem.imagePath) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
            })
    }
}
