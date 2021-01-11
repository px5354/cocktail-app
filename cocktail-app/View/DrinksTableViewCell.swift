//
//  DrinksTableViewCell.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-04.
//

import Foundation
import UIKit

class DrinksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var drinkIdLabel: UILabel!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var bookmarkedImage: UIImageView!
    
    func setupThumbnailImageView() {
        imageThumbnail?.contentMode = .scaleAspectFit
    }
    
    func setupView(with drink: Drink, isBookmarked: Bool) {
        drinkIdLabel?.text = drink.id
        drinkNameLabel?.text = drink.name
        setupThumbnailImageView()
        
        bookmarkedImage.isHidden = !isBookmarked
    }
    
    func setupImageView(with image: UIImage?) {
        DispatchQueue.main.async {
            self.imageThumbnail?.image = image ?? UIImage()
        }
    }

}
