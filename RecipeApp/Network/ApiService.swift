//
//  ApiService.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import Foundation


struct ApiService {
    
    static let shared = ApiService()
    
    func fetchCategories(completion: @escaping (CategoryResponse) -> Void) {
        let url = "categories.php"
        API.shared.fetchRequest(url: url, generalType: CategoryResponse.self) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchMeals(category: String, completion: @escaping (MealResponse) -> Void) {
        let url = "filter.php?c=\(category)"
        API.shared.fetchRequest(url: url, generalType: MealResponse.self) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchRecipe(id: String, completion: @escaping (MealDetailsResponse) -> Void) {
        let url = "lookup.php?i=\(id)"
        API.shared.fetchRequest(url: url, generalType: MealDetailsResponse.self) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
