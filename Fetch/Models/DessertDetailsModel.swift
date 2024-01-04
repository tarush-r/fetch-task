//
//  DessertDetailsModel.swift
//  Fetch
//
//  Created by Tarush Tejas Rajput on 1/4/24.
//

import Foundation

struct DessertDetails: Codable, Identifiable {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    // Add more ingredients as needed
    
    var id: String? {
            return idMeal
        }
    
    var strIngredients: [String] {
            var ingredients = [String]()
            for index in 1...20 {
                let ingredientKey = "strIngredient\(index)"
                let mirror = Mirror(reflecting: self)
                let ingredient = mirror.children.first { $0.label == ingredientKey }?.value as? String
                
                guard let unwrappedIngredient = ingredient, !unwrappedIngredient.isEmpty else {
                    break
                }
                
                ingredients.append(unwrappedIngredient)
            }
            return ingredients
        }
    
    var strMeasures: [String] {
            var measures = [String]()
            for index in 1...20 {
                let measureKey = "strMeasure\(index)"
                let mirror = Mirror(reflecting: self)
                let measure = mirror.children.first { $0.label == measureKey }?.value as? String
                
                guard let unwrappedMeasure = measure, !unwrappedMeasure.isEmpty else {
                    break
                }
                
                measures.append(unwrappedMeasure)
            }
            return measures
        }
    
    
    var ingredientsAndMeasurements: [String] {
        var result = [String]()
        if let ingredient1 = strIngredient1 {
            result.append("\(ingredient1) - \(strMeasure1 ?? "")")
        }
        if let ingredient2 = strIngredient2 {
            result.append("\(ingredient2) - \(strMeasure2 ?? "")")
        }
        // Add more ingredients and measures as needed
        return result
    }
    
    // Add more properties as needed
    // ...
}

