//
//  FlickerItem.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation

struct FlickerItem: Codable, Identifiable, Equatable {
    let id: String
    let farm: Int
    let title: String
    let server: String
    let secret: String
    
    static func == (lhs: FlickerItem, rhs: FlickerItem) -> Bool {
        lhs.id == rhs.id
    }
}
