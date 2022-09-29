//
//  Brand.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 26/09/22.
//

import Foundation

struct Brand: Codable {
    var name: String
    var image: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
    }
}
