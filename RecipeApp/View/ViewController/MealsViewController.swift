//
//  MealsViewController.swift
//  RecipeAPp
//
//  Created by Khavishini on 15/02/2024.
//

import UIKit
import RxSwift

class MealsViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var mealCollectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    let cellIdentifier = "MealCollectionViewCell"
    let segueName = "recipeSegue"
    let viewModel = MealViewModel()
    var category: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchMeals(category: category ?? "Seafood")
        setupCollectionView()
    }

    func setupCollectionView() {
        
        mealCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        mealCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        viewModel.mealsResult.bind(to: mealCollectionView.rx.items(cellIdentifier: cellIdentifier, cellType: MealCollectionViewCell.self)) { (cv, meal, cell) in
            cell.configure(meal: meal)
        }
        .disposed(by: disposeBag)
        
        mealCollectionView.rx.modelSelected(MealModel.self).subscribe(onNext: { [weak self] model in
            self?.viewModel.cellTapped.accept(model.idMeal)
            self?.performSegue(withIdentifier: self?.segueName ?? "recipeSegue", sender: self)
        }).disposed(by: disposeBag)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MealDetailsViewController {
            vc.id = viewModel.cellTapped.value
        }
    }

}

extension MealsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width - 25
            let cellWidth = width / 2
            return CGSize(width: cellWidth, height: cellWidth)
        
        }
}
