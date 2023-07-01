//
//  EMDish.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 29.06.2023.
//

import Foundation

struct EMDish: Codable, Hashable {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

enum Teg: String, Codable, CaseIterable {
    case всеМеню = "Все меню"
    case салаты = "Салаты"
    case сРисом = "С рисом"
    case сРыбой = "С рыбой"
    case роллы = "Роллы"
}

struct DishResponseModel: Codable {
    let dishes: [EMDish]
}
