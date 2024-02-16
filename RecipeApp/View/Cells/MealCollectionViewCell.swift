//
//  MealCollectionViewCell.swift
//  RecipeAPp
//
//  Created by Khavishini on 15/02/2024.
//

import UIKit
import Kingfisher

class MealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealView: UIView!
    
    func configure(meal: MealModel) {
        mealImageView.kf.setImage(with: URL(string: meal.strMealThumb))
        mealTitleLabel.text = meal.strMeal
        mealView.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.2)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
    }
}
