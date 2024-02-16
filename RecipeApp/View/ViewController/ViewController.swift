//
//  ViewController.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    let viewModel = CategoryViewModel()
    let disposeBag = DisposeBag()
    let cellIdentifier =  "categoryTableViewCell"
    let segueName = "mealSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCategories()
        setupTableView()
    }
    
    func setupTableView() {
        
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        viewModel.categoriesResult.bind(to: categoryTableView.rx.items) { (tv, _, category) in
            guard let cell = tv.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? CategoryTableViewCell else { return UITableViewCell() }
            cell.configureCell(category: category)
            return cell
        }
        .disposed(by: disposeBag)
        
        categoryTableView.rx.modelSelected(CategoryModel.self).subscribe(onNext: { [weak self] category in
            // TODO: - Perform Navigation
            self?.viewModel.cellTapped.accept(category.strCategory)
            self?.performSegue(withIdentifier: self?.segueName ?? "mealSegue", sender: self)
            
            
        }).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MealsViewController {
            vc.category = viewModel.cellTapped.value
        }
    }
    
    

}

