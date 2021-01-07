//
//  Drink.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation

struct Drink: Decodable {
    let id: String
    let name: String
    let thumbnailLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumbnailLink = "strDrinkThumb"
      }
}


