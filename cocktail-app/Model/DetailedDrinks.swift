//
//  DetailedDrinks.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-05.
//

import Foundation

struct DetailedDrinks: Decodable {
  let all: [DetailedDrink]
  
  enum CodingKeys: String, CodingKey {
    case all = "drinks"
  }
}
