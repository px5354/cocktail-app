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
    
    private var detailedDrinkViewModel : DetailedDrinkViewModel = DetailedDrinkViewModel()
    var drinkId = String()
    //instructions and max 15 ingredients
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailedDrink()
    }
    
    func setupThumbnailImageView() {
        drinkImage?.contentMode = .scaleAspectFit
    }
    
    func setupView() {
        self.drinkNameLabel.text = self.detailedDrinkViewModel.detailedDrink()?.name
        self.drinkIdLabel.text = self.detailedDrinkViewModel.detailedDrink()?.id
        self.drinkInstructionsLabel.text = self.detailedDrinkViewModel.detailedDrink()?.instructions
        self.drinkInstructionsLabel.sizeToFit()
        self.drinkIngredientsLabel.text = self.detailedDrinkViewModel.detailedDrink()?.listIngredients.joined(separator: "\n")
        self.drinkIngredientsLabel.sizeToFit()
        
        setupThumbnailImageView()
    }
    
    func setupImageView(with image: UIImage?) {
        DispatchQueue.main.async {
            self.drinkImage?.image = image ?? UIImage()
        }
    }

    func fetchDetailedDrink() {
        detailedDrinkViewModel.getDetailedDrink(id: self.drinkId) {
            self.setupView()
            self.detailedDrinkViewModel.getImage() { image in
                self.setupImageView(with: image)
            }
        }
    }
}
