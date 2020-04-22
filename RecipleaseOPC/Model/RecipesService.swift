//
//  RecipeService.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import Foundation

final class RecipesService {
    
    enum NetworkError: Error {
        case noData, incorrectResponse, undecodable
    }
    
    let apiKey = ApiConfig.reciplease
    
    // MARK: - Properties
    
    private var recipesSession: AlamoSession
    
    init(recipesSession: AlamoSession = RecipesSession()) {
        self.recipesSession = recipesSession
    }
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<RecipeData, Error>) -> Void) {
        let stringIngredients = ingredients.joined(separator: "+")
        guard let url = URL(string:"https://api.edamam.com/search?q=\(stringIngredients)&app_id=6ec466ad&app_key=\(apiKey)") else { return }
        recipesSession.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(NetworkError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(NetworkError.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipeData.self, from: data) else {
                callback(.failure(NetworkError.undecodable))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
