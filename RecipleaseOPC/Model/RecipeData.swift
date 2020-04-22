// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipe = try? newJSONDecoder().decode(Recipe.self, from: jsonData)

import Foundation

// MARK: - Recipe

struct RecipeData: Decodable {
    var hits: [Hit]
}

// MARK: - Hit

struct Hit: Decodable {
    var recipe: RecipeInformations
}

// MARK: - RecipeClass

struct RecipeInformations: Decodable {
    let label: String
    var image: String
    let url: String
    let ingredients: [Ingredient]
    let totalTime: Int
    let yield: Int
}

// MARK: - Ingredient

struct Ingredient: Decodable {
    let text: String
    let weight: Double
}

struct RecipeRepresentable {
    let label: String
    let image: Data?
    let url: String
    let ingredients: [String]
    let totalTime: String?
    let yield: String
}
