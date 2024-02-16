//
//  MealModel.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import Foundation

struct MealResponse: Codable {
    let meals: [MealModel]
}

struct MealModel: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
