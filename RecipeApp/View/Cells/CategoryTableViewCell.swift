//
//  CategoryTableViewCell.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import UIKit
import Kingfisher

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!

    
    func configureCell(category: CategoryModel) {
        titleLabel.text = category.strCategory
        categoryImageView.kf.setImage(with: URL(string: category.strCategoryThumb))
    }

    
}
