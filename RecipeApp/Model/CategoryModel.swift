//
//  CategoryModel.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: [CategoryModel]
}

struct CategoryModel: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
