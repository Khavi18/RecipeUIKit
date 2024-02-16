//
//  MealViewModel.swift
//  RecipeAPp
//
//  Created by Khavishini on 15/02/2024.
//

import Foundation
import RxSwift
import RxRelay

struct MealViewModel {
    
    let mealsResult = BehaviorRelay<[MealModel]>(value: [])
    let cellTapped = BehaviorRelay<String>(value: "")
    
    func fetchMeals(category: String) {
        ApiService.shared.fetchMeals(category: category) { result in
            mealsResult.accept(result.meals)
        }
    }
}
