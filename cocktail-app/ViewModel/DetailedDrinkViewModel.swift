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
    private var cocktailService = CocktailService.sharedInstance
    
    func detailedDrink() -> DetailedDrink? {
        return detailedDrinkData
    }
    
    var isBookmarked: Bool? {
        if let id = detailedDrinkData?.id {
           return cocktailService.isBookmarked(id: id)
        }
        return nil
    }
    
    func bookmarkDrink(id: String) {
        cocktailService.bookmark(id: id)
    }
    
    func unBookmarkDrink(id: String) {
        cocktailService.unBookmark(id: id)
    }

    func getImage(_ completion: ((UIImage?) -> Void)?) {
        if let drinkThumbnailUrl = URL(string: detailedDrinkData?.thumbnailLink ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/Cocktail-glass.jpg"){

            cocktailService.fetchImageData(from: drinkThumbnailUrl) { (uiImage: UIImage?, error: Error?) in
                if let image = uiImage {
                    completion?(image)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    func getDetailedDrink(id: String ,completion: (() -> Void)?) {
        cocktailService.fetchDetailedDrinkById(id: id, completion: { (detailedDrink) in
            self.detailedDrinkData = detailedDrink
            completion?()
        })
    }
}
