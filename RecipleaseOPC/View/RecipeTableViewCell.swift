//
//  RecipeTableViewCell.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 12/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var recipe: Hit? {
        didSet {
            if let yields = recipe?.recipe.yield {
                likeLabel.text = "\(yields)"
            } else {
                likeLabel.isHidden = true
            }
            
            if let time = recipe?.recipe.totalTime {
                timeLabel.text = "\(time.convertTime)"
            } else {
                timeLabel.isHidden = true
            }
            if let title = recipe?.recipe.label {
                titleLabel.text = "\(title)"
            }
            
            descriptionLabel.text = recipe?.recipe.ingredients.map { $0.text }.joined(separator: ", ")
            
            if let images = recipe?.recipe.image {
                recipeImageView.sd_setImage(with: URL(string: (images)))
            }
        }
    }
    
    var favoriteRecipe: FavoriteRecipe? {
        didSet {
            if let yields = favoriteRecipe?.yield {
                likeLabel.text = "\(yields)"
            } else {
                likeLabel.isHidden = true
            }
            
            if let time = favoriteRecipe?.time {
                timeLabel.text = "\(time)"
            } else {
                timeLabel.isHidden = true
            }
            if let title = favoriteRecipe?.name {
                titleLabel.text = "\(title)"
            }
            
            descriptionLabel.text = favoriteRecipe?.ingredient?.joined(separator: ", ")
            
            if let images = favoriteRecipe?.image {
                recipeImageView.image = UIImage(data: images)
            }
        }
    }
}
