//
//  FlickerImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Ahmed Elsman on 08/08/2022.
//

import Foundation
import SwiftUI

class FlickerImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private let flickerItem: FlickerItem
    private let dataService: FlickerImageService
    
    init(flickerItem: FlickerItem) {
        self.flickerItem = flickerItem
        self.dataService = FlickerImageService(flickerItem: flickerItem)
    }
    
    func getFlickerImage() async {
        if let data = await dataService.getFlickerImageAsync() {
            await MainActor.run {
                self.image = UIImage(data: data)
            }
        }
    }
}
