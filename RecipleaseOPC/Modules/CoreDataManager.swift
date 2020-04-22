//
//  CoreDataManager.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 11/03/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoriteRecipes: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    func addFavorites(name: String, image: Data, ingredient: [String], url: String, time: String, yield: String) {
        let recipe = FavoriteRecipe(context: managedObjectContext)
        recipe.image = image
        recipe.ingredient = ingredient
        recipe.name = name
        recipe.url = url
        recipe.time = time
        recipe.yield = yield
        coreDataStack.saveContext()
    }
    
    func deleteRecipeFromFavorite(recipeName: String) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        let nsPredicate = NSPredicate(format: "name == %@", recipeName)
        request.predicate = nsPredicate
        guard let recipes = try? managedObjectContext.fetch(request) else { return }
        guard let recipe = recipes.first else { return }
        managedObjectContext.delete(recipe)
//        if let objects = try? managedObjectContext.fetch(request) {
//            objects.forEach { managedObjectContext.delete($0)}
//        }
        coreDataStack.saveContext()
    }
    
    func createTask(name: String) {
        let favoriteRecipes = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipes.name = name
        coreDataStack.saveContext()
    }
    
    func deleteAllTasks() {
        favoriteRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func checkIfRecipeIsInFavorite(recipeName: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", recipeName)
        guard let recipes = try? managedObjectContext.fetch(request) else { return false }
        if recipes.isEmpty {return false}
        return true
    }
}


