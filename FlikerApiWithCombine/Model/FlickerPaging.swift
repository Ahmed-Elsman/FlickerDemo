//
//  FlickerPaging.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation

struct FlickerPaging: Codable {
    let photo: [FlickerItem]
    let page: Int
    let pages: Int
}
