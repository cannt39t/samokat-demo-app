//
//  DishVM.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 29.06.2023.
//

import Foundation
import Combine


final class DishVM: ObservableObject {
    
    private let baseURL = R.API.base
    private let endpoint = R.API.dishEndpoint
    private var dishesAll: [EMDish] = []
    private var bag = Set<AnyCancellable>()
    
    @Published var teg: Teg = .всеМеню
    @Published var dishes: [EMDish] = []
    @Published var selectedDish: EMDish?
    
    static let shared = DishVM()
    
    init() {
        loadDishes()
    }
    
    func loadDishes() {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else { return }
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: DishResponseModel.self, decoder: JSONDecoder())
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] response in
                self?.dishesAll = response.dishes
                self?.applyFilter()
            }
            .store(in: &bag)
    }
    
    private func applyFilter() {
        $teg
            .debounce(for: .milliseconds(0), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { [unowned self] _ in
                if teg == .всеМеню {
                    return dishesAll
                }
                return dishesAll.filter { dish in
                    return dish.tegs.contains(teg)
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$dishes)
    }
}
