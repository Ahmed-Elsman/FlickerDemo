//
//  FlickerItem.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation

struct FlickerItem: Codable, Identifiable, Equatable {
    let id,title,server,secret, imagePath: String
    let farm: Int
    
    static func == (lhs: FlickerItem, rhs: FlickerItem) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: String, title: String, server: String, secret: String, farm: Int) {
        self.id = id
        self.title = title
        self.server = server
        self.secret = secret
        self.farm = farm
        self.imagePath = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        server = try values.decode(String.self, forKey: .server)
        secret = try values.decode(String.self, forKey: .secret)
        farm = try values.decode(Int.self, forKey: .farm)
        imagePath = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
