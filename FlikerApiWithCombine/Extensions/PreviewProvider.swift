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
    private init() { }
    
    let searchVM = SearchListViewModel()
    
    let flickerItem = FlickerItem(id: "52268694936", farm: 66, title: "2022 Cars and Coffee Kernersville August (226 of 643).jpg", server: "65535", secret: "0d0d379f37")
}
