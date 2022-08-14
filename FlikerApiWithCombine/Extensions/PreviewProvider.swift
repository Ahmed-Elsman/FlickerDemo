//
//  PreviewProvider.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/9/21.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    static let flickerSearchDataService = FlickerSearchDataService()
    
    private init() { }
    
    let searchVM = SearchListViewModel(flickerSearchDataService: DeveloperPreview.flickerSearchDataService)
    
    let flickerItem = FlickerItem(id: "52268694936", title: "2022 Cars and Coffee Kernersville August (226 of 643).jpg", server: "65535", secret: "0d0d379f37", farm: 66)
}

