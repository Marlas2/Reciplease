//
//  RecipesPageViewController.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit
import SDWebImage

class RecipesPageViewController: UIViewController {
    
    // MARK: - Variables
    
    var recipe: Hit?
    var recipes: RecipeData?
    
    // MARK: - Outlets

    @IBOutlet weak var recipesTableView: UITableView!
    
    /// Segue to the DetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsViewController = segue.destination as? DetailsViewController else { return }
        guard let recipe = recipe?.recipe else { return }
        let recipeRepresentable = RecipeRepresentable(label: recipe.label, image: recipe.image.data, url: recipe.url, ingredients: recipe.ingredients.map {$0.text}, totalTime: recipe.totalTime.convertTime , yield: String(recipe.yield))
        detailsViewController.recipeRepresentable = recipeRepresentable
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.backgroundColor = UIColor.darkGray
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipesTableView.register(nib, forCellReuseIdentifier: "recipeDetail")
    }
}

// MARK: - Extensions

extension RecipesPageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeDetail", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.textColor = UIColor.white
        cell.recipe = recipes?.hits[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.hits.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width/1.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = recipes?.hits[indexPath.row]
        
        performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
}
