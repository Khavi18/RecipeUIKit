//
//  MealDetailsViewModel.swift
//  RecipeAPp
//
//  Created by Khavishini on 15/02/2024.
//

import Foundation
import RxSwift
import RxRelay

struct MealDetailsViewModel {
    
    let mealsDetailsResult = PublishSubject<MealDetailsModel>()
    let ingredientsSubject = PublishSubject<[String: String]>()
    let quantitySubject = PublishSubject<[String]>()
    
    func fetchMealDetails(id: String) {
        ApiService.shared.fetchRecipe(id: id) { result in
            mealsDetailsResult.onNext(result.meals[0])
            getIngredientsArray(meal: result.meals[0])
        }
    }
    
    func getIngredientsArray(meal: MealDetailsModel) {
        var ingredientArray = [String]()
        var quantityDict = [String: String]()
        var meals = [String: Any]()
        do {
            meals = try meal.asDictionary()
        } catch {
            print("Error parsing as dictionary: " + error.localizedDescription)
        }
        
        for index in 1..<21 {
            let ingredient = meals["strIngredient\(index)"]
            let quantity = meals["strMeasure\(index)"]
            if ingredient != nil, let ing = ingredient as? String, ing.trimmingCharacters(in: .whitespaces) != "" {
                ingredientArray.append(ing.capitalized)
            }
            if quantity != nil, let amount = quantity as? String, amount.trimmingCharacters(in: .whitespaces) != "" {
                quantityDict[ingredientArray[index - 1]] = amount
            }
        }
        ingredientsSubject.onNext(quantityDict)
    }
    
    
}


