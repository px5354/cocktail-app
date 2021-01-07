//
//  DetailedDrinkViewModel.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-05.
//

import Foundation

class DetailedDrinkViewModel {

    private var cocktailService: CocktailService?
    private(set) var detailedDrinkData : DetailedDrink! {
        didSet {
            self.bindDetailedDrinkViewModelToController()
        }
    }
    
    var bindDetailedDrinkViewModelToController : (() -> ()) = {}
        
    init(id: String) {
        self.cocktailService = CocktailService()
        getDetailedDrink(id: id)
    }
    
    func getDetailedDrink(id: String) {
        self.cocktailService?.fetchDetailedDrinkById(id: id, completion: { (detailedDrink) in
            self.detailedDrinkData = detailedDrink
        })
    }
}
