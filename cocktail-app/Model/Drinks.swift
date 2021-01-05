//
//  Drinks.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation

struct Drinks: Decodable {
  let all: [Drink]
  
  enum CodingKeys: String, CodingKey {
    case all = "drinks"
  }
}
