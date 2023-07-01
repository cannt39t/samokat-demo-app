//
//  DishCartPresentManager.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 01.07.2023.
//

import Foundation


final class DishCartPresentManager: ObservableObject {
    @Published var isPresent: Bool = false
    @Published var dish: EMDish?
}
