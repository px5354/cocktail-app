//
//  DrinksViewModel.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation

class DrinksViewModel {

    private var cocktailService: CocktailService?
    private(set) var drinksData : [Drink]! {
        didSet {
            self.bindDrinksViewModelToController()
        }
    }
    
    var bindDrinksViewModelToController : (() -> ()) = {}
        
    init() {
        self.cocktailService = CocktailService()
        getOrdinaryDrinks()
    }
    
    func getOrdinaryDrinks() {
        self.cocktailService?.fetchDrinksByCategory(category: "Ordinary_Drink", completion: { (drinks) in
            self.drinksData = drinks.all
        })
    }
}
