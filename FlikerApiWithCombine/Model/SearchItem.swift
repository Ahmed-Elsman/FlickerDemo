//
//  SearchItem.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 07/08/2022.
//

import Foundation

protocol Searchable: Equatable, Codable {
    var id: String { get }
    var title: String { get }
    
    init(id: String, title: String)
    
}

struct SearchItem: Identifiable, Searchable {
    let id: String
    let title: String
    
    init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
    }
    
    static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
        lhs.title == rhs.title
    }
}
