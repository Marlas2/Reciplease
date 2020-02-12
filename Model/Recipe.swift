// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipe = try? newJSONDecoder().decode(Recipe.self, from: jsonData)

import Foundation

// MARK: - Recipe
struct Recipe: Decodable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    var hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    var recipe: RecipeClass
}

// MARK: - RecipeClass
struct RecipeClass: Decodable {
    let uri: String
    let label: String
    var image: String
    let source: String
    let url: String
    let ingredients: [Ingredient]
    let totalTime: Int
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let weight: Double
}
