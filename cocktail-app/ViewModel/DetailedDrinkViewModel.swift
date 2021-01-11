//
//  DetailedDrinkViewModel.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-05.
//

import Foundation
import UIKit

class DetailedDrinkViewModel {

    private var detailedDrinkData : DetailedDrink?
    
    func detailedDrink() -> DetailedDrink? {
        return detailedDrinkData
    }

    func getImage(_ completion: ((UIImage?) -> Void)?) {
        if let drinkThumbnailUrl = URL(string: detailedDrinkData?.thumbnailLink ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/Cocktail-glass.jpg"){

            CocktailService.sharedInstance.fetchImageData(from: drinkThumbnailUrl) { (uiImage: UIImage?, error: Error?) in
                if let image = uiImage {
                    completion?(image)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    func getDetailedDrink(id: String ,completion: (() -> Void)?) {
        CocktailService.sharedInstance.fetchDetailedDrinkById(id: id, completion: { (detailedDrink) in
            self.detailedDrinkData = detailedDrink
            completion?()
        })
    }
}
