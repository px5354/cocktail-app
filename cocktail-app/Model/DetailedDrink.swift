//
//  DetailedDrink.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-05.
//

import Foundation
import Alamofire

struct DetailedDrink: Decodable {
    // TODO: add measures
    let id: String
    let name: String
    let category: String
    let instructions: String?
    let thumbnailLink: String?
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case thumbnailLink = "strDrinkThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
      }
}

extension DetailedDrink {
  var listIngredients: [String] {
    [
        ingredient1,ingredient2,ingredient3,ingredient4,ingredient5,
        ingredient6,ingredient7,ingredient8,ingredient9,ingredient10,
        ingredient11,ingredient12,ingredient13,ingredient14,ingredient15
    ].compactMap { $0 }
  }
}
