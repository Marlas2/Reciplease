//
//  DetailsViewController.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 20/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var recipeRepresentable: RecipeRepresentable?
    var coreDataManager: CoreDataManager?
    
    // MARK: - Outlets
    
    @IBOutlet weak var favoriteRecipeButton: UIBarButtonItem!
    @IBOutlet weak var detailsIngredientsLabel: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var detailsLikeLabel: UILabel!
    @IBOutlet weak var detailsTimeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.backgroundColor = UIColor.darkGray
        if let yields = recipeRepresentable?.yield {
            detailsLikeLabel.text = "\(yields)"
        } else {
            detailsLikeLabel.isHidden = true
        }
        if let time = recipeRepresentable?.totalTime {
            detailsTimeLabel.text = "\(time)"
        } else {
            detailsTimeLabel.isHidden = true
        }
        if let imageData = recipeRepresentable?.image {
            detailsImageView.image = UIImage(data: imageData)
        } else {
            detailsImageView.image = UIImage(named: "1024")
        }
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {return}
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
    }
    
    // MARK: - Actions
    
    /// Open the web site for the current recipe
    @IBAction func getDirectionsButton(_ sender: UIButton) {
        guard let url = URL(string: recipeRepresentable?.url ?? "") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func addFavoritesButton(_ sender: UIBarButtonItem) {
        guard let coreDataManager = coreDataManager else { return }
        if  coreDataManager.checkIfRecipeIsInFavorite(recipeName: recipeRepresentable?.label ?? "") {
            favoriteRecipeButton.image = UIImage(named: "emptyStar")
            deleteFromFavorites()
        } else {
            favoriteRecipeButton.image = UIImage(named: "star")
            addToFavorites()
        }
    }
    
    /// Update my favorite button
    private func updateFavoriteButton() {
        guard let coreDataManager = coreDataManager else { return }
        if  coreDataManager.checkIfRecipeIsInFavorite(recipeName: recipeRepresentable?.label ?? "") {
            favoriteRecipeButton.image = UIImage(named: "star")
        } else {
            favoriteRecipeButton.image = UIImage(named: "emptyStar")
        }
    }
    
    /// Add recipe to favorites
    private func addToFavorites(){
        guard let name = recipeRepresentable?.label, let image = recipeRepresentable?.image, let ingredients = recipeRepresentable?.ingredients, let url = recipeRepresentable?.url, let time = recipeRepresentable?.totalTime, let yield = recipeRepresentable?.yield else {return}
        coreDataManager?.addFavorites(name: name, image: image, ingredient: ingredients, url: url, time: time, yield: yield)
    }
    
    /// Delete recipes from favorites
    private func deleteFromFavorites() {
        coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeRepresentable?.label ?? "")
    }
}

// MARK: - Extension

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeRepresentable?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)
        let ingredient = recipeRepresentable?.ingredients[indexPath.row]
        cell.textLabel?.text = "- " + ingredient!
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}

