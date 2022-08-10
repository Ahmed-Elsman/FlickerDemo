//
//  FlickerImageService.swift
//  SwiftfulCrypto
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation
import SwiftUI

class FlickerImageService {
    
    private let flickerItem: FlickerItem
    
    init(flickerItem: FlickerItem) {
        self.flickerItem = flickerItem
    }
    
    func getFlickerImageAsync() async -> Data? {
        await downloadFlickerImageAsync()
    }
    
    private func downloadFlickerImageAsync() async -> Data? {
        guard let url = URL(string: "https://farm\(flickerItem.farm).static.flickr.com/\(flickerItem.server)/\(flickerItem.id)_\(flickerItem.secret).jpg") else { return nil }
        return try? await NetworkingManager.downloadWithConcurrency(url: url)
    }
}
