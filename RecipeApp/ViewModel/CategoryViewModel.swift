//
//  CategoryViewModel.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import Foundation
import RxSwift
import RxRelay

struct CategoryViewModel {
    
    let categoriesResult = BehaviorRelay<[CategoryModel]>(value: [])
    let cellTapped = BehaviorRelay<String>(value: "")
    
    func fetchCategories() {
        ApiService.shared.fetchCategories { result in
            categoriesResult.accept(result.categories)
        }
    }
    
}
