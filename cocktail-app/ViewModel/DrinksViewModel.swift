//
//  DrinksViewModel.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation
import UIKit

class DrinksViewModel {

    private var drinksData : [Drink]?
    private var filteredDrinksData : [Drink]?
    var cellIdentifier = "DrinksTableViewCell"
    
    var numberOfDrinks: Int {
        return drinksData?.count ?? 0
    }
    
    func drink(at row: Int) -> Drink? {
        return drinksData?[row]
    }
    
    var numberOfFilteredDrinks: Int {
        return filteredDrinksData?.count ?? 0
    }
    
    func filteredDrink(at row: Int) -> Drink? {
        return filteredDrinksData?[row]
    }
    
    func filterDrinks(with searchText: String) {
        filteredDrinksData = drinksData?.filter { (drink: Drink) -> Bool in
            return drink.name.lowercased().contains(searchText.lowercased())
          }
    }

    func drinkFromCurrentData(at row: Int) -> Drink? {
        return filteredDrinksData?.isEmpty ?? true ? drink(at: row) : filteredDrink(at: row)
    }
    
    func getImage(at row: Int,_ completion: ((UIImage?) -> Void)?) {
        let urlString = drinkFromCurrentData(at: row)?.thumbnailLink ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/Cocktail-glass.jpg"
        if let drinkThumbnailUrl = URL(string: urlString){
            CocktailService.sharedInstance.fetchImageData(from: drinkThumbnailUrl) { (uiImage: UIImage?, error: Error?) in
                if let image = uiImage {
                    completion?(image)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    func getOrdinaryDrinks(_ completion: (() -> Void)?) {
        CocktailService.sharedInstance.fetchDrinksByCategory(category: "Ordinary_Drink", completion: { (drinks) in
            self.drinksData = drinks.all
            completion?()
        })
    }
}
