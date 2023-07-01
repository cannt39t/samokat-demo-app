//
//  EMCategory.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 29.06.2023.
//

import Foundation


struct EMCategory: Codable, Hashable {
    let id: Int
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

struct CategoryResponseModel: Codable, Hashable {
    let сategories: [EMCategory]
}
