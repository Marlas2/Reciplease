//
//  SearchPageViewController.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit

class SearchPageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addIngredientsTextField: UITextField!
    @IBOutlet weak var fridgeLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    // MARK: - Variables
    
    var recipesService = RecipesService()
    var allIngredients = [String]()
    var recipes: [Hit]?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesPageViewController = segue.destination as? RecipesPageViewController else { return }
        recipesPageViewController.recipes = recipes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        addIngredientsTextField.resignFirstResponder()
    }
    
    @IBAction func addIngredientsButton(_ sender: UIButton) {
        addIngredients()
        ingredientsTableView.reloadData()
        addIngredientsTextField.text = ""
    }
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
        allIngredients = [String]()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func searchRecipesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "searchSegue", sender: nil)
        toggleActivityIndicator(shown: true)
        recipesService.getRecipes(ingredients: allIngredients) { result in
            switch result {
            case .success(let recipes):
                self.recipes = recipes.hits
            case .failure:
                self.presentAlert(title: "Erreur", message: "No recipes found")
            }
        }
        update(shown: true)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        searchActivityIndicator.startAnimating()
    }
    
    private func update(shown: Bool) {
        searchButton.isHidden = !shown
        searchActivityIndicator.stopAnimating()
    }
    
    func addIngredients() {
        guard let enteredText = addIngredientsTextField.text else { return }
        allIngredients.append(enteredText)
    }
}



// MARK: - Extensions

extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        let ingredients = allIngredients[indexPath.row]
        cell.textLabel?.text = ingredients
        return cell
    }
}

