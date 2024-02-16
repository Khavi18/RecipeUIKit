//
//  MealDetailsViewController.swift
//  RecipeAPp
//
//  Created by Khavishini on 15/02/2024.
//

import UIKit
import RxSwift
import Kingfisher

class MealDetailsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = MealDetailsViewModel()
    var id = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ingredientStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMealDetails(id: id)
        setupUI()
    }
    
    func setupUI() {
        viewModel
            .mealsDetailsResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] meal in
            self?.titleLabel.text = meal.strMeal?.uppercased()
            self?.instructionLabel.text = meal.strInstructions
            self?.mealImageView.kf.setImage(with: URL(string: meal.strMealThumb!))
        }).disposed(by: disposeBag)
        
        viewModel
            .ingredientsSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] ingredients in
                self?.setupStackViews(ingredients: ingredients)
            }).disposed(by: disposeBag)
    }
    
    func setupStackViews(ingredients: [String: String]) {
        ingredients.forEach { (ingredient, amount) in
            let ingredientLabel = UILabel()
            ingredientLabel.font = UIFont.systemFont(ofSize: 16)
            ingredientLabel.backgroundColor = UIColor.clear
            ingredientLabel.textColor = .darkGray
            ingredientLabel.text = "\(ingredient) - \(amount)"
            ingredientStackView.addArrangedSubview(ingredientLabel)
        }
    }

}
