//
//  DetailedViewController.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-05.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkIdLabel: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkInstructionsLabel: UILabel!
    @IBOutlet weak var drinkIngredientsLabel: UILabel!

    private var detailedDrinkViewModel : DetailedDrinkViewModel!
    var drinkId = String()
    //instructions and max 15 ingredients
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailedDrinkViewModel = DetailedDrinkViewModel(id: self.drinkId)
        self.detailedDrinkViewModel.bindDetailedDrinkViewModelToController = {
            let detailedDrink = self.detailedDrinkViewModel.detailedDrinkData

            self.drinkNameLabel.text = detailedDrink?.name
            self.drinkIdLabel.text = detailedDrink?.id
            self.drinkInstructionsLabel.text = detailedDrink?.instructions
            self.drinkInstructionsLabel.sizeToFit()
            self.drinkIngredientsLabel.text = detailedDrink?.listIngredients.joined(separator: "\n")
            self.drinkIngredientsLabel.sizeToFit()
            if let link = detailedDrink?.thumbnailLink {
                self.fetchImage(from: link){ (imageData) in
                        if let data = imageData {
                            // referenced imageView from main thread
                            // as iOS SDK warns not to use images from
                            // a background thread
                            DispatchQueue.main.async {
                                self.drinkImage.image = UIImage(data: data)
                            }
                        } else {
                            print("Error loading image");
                        }
                    }
            }
        }
    }
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
            
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image! 😢")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
    
}
