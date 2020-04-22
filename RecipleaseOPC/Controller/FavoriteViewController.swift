//
//  FavoriteViewController.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 11/03/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Variables
    
    private var recipeRepresentable: RecipeRepresentable?
    private var coreDataManager: CoreDataManager?
    
    // MARK: - Outlets
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {return}
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "recipeDetail")
    }
    
    /// Segue to DetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsViewController = segue.destination as? DetailsViewController else {return}
        detailsViewController.recipeRepresentable = recipeRepresentable
    }
}

// MARK: - Extension

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteRecipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeDetail", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let favoriteRecipe = coreDataManager?.favoriteRecipes[indexPath.row]
        cell.favoriteRecipe = favoriteRecipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRecipe = coreDataManager?.favoriteRecipes[indexPath.row]
        let recipeRepresentable = RecipeRepresentable(label: (favoriteRecipe?.name)!, image: favoriteRecipe?.image, url: (favoriteRecipe?.url)!, ingredients: (favoriteRecipe?.ingredient)!, totalTime: favoriteRecipe?.time, yield: (favoriteRecipe?.yield)!)
        self.recipeRepresentable = recipeRepresentable
        self.performSegue(withIdentifier: "favoriteIdentifier", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let recipeName = coreDataManager?.favoriteRecipes[indexPath.row].name else {return}
        coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeName)
        favoriteTableView.reloadData()
        guard coreDataManager?.favoriteRecipes.isEmpty == true else {
            return
        }
    }
}



//Mettre des prints dans les func
//Reecrire a la main
//Changer les noms (ingredients)
//Design + Etoile
//Refaire le favorite
//Revenir a l'écran précédent coté coredata
//Test coredata
