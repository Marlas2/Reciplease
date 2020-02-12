//
//  RecipePageViewController.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit
import SDWebImage

class RecipesPageViewController: UIViewController {

    @IBOutlet weak var recipesTableView: UITableView!
    var recipes: [Hit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.register(UINib(nibName: "RecipesTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeDetail")
    }
    var recipesImages = [String]()
}

////extension RecipesPageViewController: UITableViewDelegate, UITableViewDataSource {
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipesDetails", for: indexPath) as? RecipesTableViewCell else {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipesDetails", for: indexPath)
////            fatalError()
////        }
////        cell.hit = recipes[indexPath.row]
////        return cell
////    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recipes?.count ?? 0
//    }
//}
