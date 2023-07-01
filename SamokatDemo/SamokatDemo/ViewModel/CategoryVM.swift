//
//  CategoryVM.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 29.06.2023.
//

import Foundation
import Combine

enum CategoryParseError: Error {
    case networkError(description: String)
    case parsingError(description: String)
}

final class CategoryVM: ObservableObject {
    
    private let baseURL = R.API.base
    private let endpoint = R.API.categotyEndpoint
    
    @Published var categories: [EMCategory] = []
    private var bag = Set<AnyCancellable>()
    
    init() {
        loadCategories()
    }
    
    func loadCategories() {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else { return }
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: CategoryResponseModel.self, decoder: JSONDecoder())
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] response in
                self?.categories = response.сategories
            }
            .store(in: &bag)
    }
}
