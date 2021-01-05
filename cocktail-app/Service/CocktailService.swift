//
//  CocktailService.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation
import Alamofire

class CocktailService {

    let endpoint = "https://www.thecocktaildb.com/api/json/v1/1";
    static let sharedInstance = CocktailService()

    func fetchDrinksByCategory(category: String = "Ordinary_Drink", completion:@escaping (Drinks)->()) {
        let request = AF.request("\(self.endpoint)/filter.php?c=\(category)")

        request.responseDecodable(of: Drinks.self) { (response) in
            guard let drinks = response.value else {
                print("Error decoding")
                print(response)
                return
            }
            completion(drinks)
        }
    }
}
