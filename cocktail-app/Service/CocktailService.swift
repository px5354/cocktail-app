//
//  CocktailService.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation
import Alamofire
import UIKit

class CocktailService {

    private let endpoint = "https://www.thecocktaildb.com/api/json/v1/1";
    private let imageCache = NSCache<NSString, UIImage>()
    var bookmarkedCocktailIds = Set<String>()

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
    
    func fetchDetailedDrinkById(id: String, completion:@escaping (DetailedDrink)->()) {
        let request = AF.request("\(self.endpoint)/lookup.php?i=\(id)")
        request.responseDecodable(of: DetailedDrinks.self) { (response) in
            guard let detailedDrinksResponse = response.value else {
                print("Error decoding detailedDrinksResponse")
                print(response)
                return
            }
            guard let detailedDrink = detailedDrinksResponse.all.first else {
                print("Error decoding detailedDrink")
                print(response)
                return
            }
            completion(detailedDrink)
        }
    }
    
    func isBookmarked(id: String) -> Bool{
        return bookmarkedCocktailIds.contains(id)
    }
    
    func bookmark(id: String) {
        bookmarkedCocktailIds.insert(id)
    }
    
    func unBookmark(id: String) {
        bookmarkedCocktailIds.remove(id)
    }

    private func downloadImage(from url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        let session = URLSession.shared
            
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching the image")
                print(error)
                completion(nil, error)
                
            } else if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image, nil)
            } else {
                print("Error fetching the image")
                completion(nil, NSError(domain: url.absoluteString, code: 401, userInfo:nil))
            }
        }
            
        dataTask.resume()
    }

    func fetchImageData(from url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {

        if let cachedImage = self.imageCache.object(forKey: url.absoluteString as NSString) {
                completion(cachedImage, nil)
            } else {
                downloadImage(from: url, completion: completion)
            }
        }
}
