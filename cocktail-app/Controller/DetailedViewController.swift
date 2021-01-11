//
//  DetailedViewController.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-05.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var drinkNameTitle: UINavigationItem!
    @IBOutlet weak var bookmarkButton: UIBarButtonItem!
    @IBOutlet weak var drinkIdLabel: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkInstructionsLabel: UILabel!
    @IBOutlet weak var drinkIngredientsLabel: UILabel!
    
    let isNotBookmarkedImage = UIImage(systemName: "bookmark")
    let isBookmarkedImage = UIImage(systemName: "bookmark.fill")
    
    private var detailedViewModel : DetailedDrinkViewModel = DetailedDrinkViewModel()
    var drinkId = String()
    //instructions and max 15 ingredients
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBookmarkButton()
        fetchDetailedDrink()
    }

    @IBAction func onClickBookmarkButton(_ sender: UIBarButtonItem) {
        guard let isBookmarked = detailedViewModel.isBookmarked, let drinkId = detailedViewModel.detailedDrink()?.id else {
            hideBookmarkButton()
            return
        }
        if isBookmarked {
            detailedViewModel.unBookmarkDrink(id: drinkId)
        } else {
            detailedViewModel.bookmarkDrink(id: drinkId)
        }

        updateBookmarkButtonImage()
    }
    
    func setupThumbnailImageView() {
        drinkImage?.contentMode = .scaleAspectFit
    }
    
    func setupView() {
        drinkNameTitle.title = detailedViewModel.detailedDrink()?.name
        drinkIdLabel.text = detailedViewModel.detailedDrink()?.id
        drinkInstructionsLabel.text = detailedViewModel.detailedDrink()?.instructions
        drinkInstructionsLabel.sizeToFit()
        drinkIngredientsLabel.text = detailedViewModel.detailedDrink()?.listIngredients.joined(separator: "\n")
        drinkIngredientsLabel.sizeToFit()
        setupThumbnailImageView()
        
        updateBookmarkButtonImage()
    }
    
    private func updateBookmarkButtonImage() {
        if let isBookmarked = detailedViewModel.isBookmarked {
            bookmarkButton.image = isBookmarked
                ?  UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
            showBookmarkButton()
        } else {
            hideBookmarkButton()
        }
    }
    
    private func showBookmarkButton() {
        bookmarkButton.isEnabled = true
        bookmarkButton.tintColor = nil
    }
    
    private func hideBookmarkButton() {
        bookmarkButton.isEnabled = false
        bookmarkButton.tintColor = UIColor.clear
    }
    
    func setupImageView(with image: UIImage?) {
        DispatchQueue.main.async {
            self.drinkImage?.image = image ?? UIImage()
        }
    }

    func fetchDetailedDrink() {
        detailedViewModel.getDetailedDrink(id: self.drinkId) {
            self.setupView()
            self.detailedViewModel.getImage() { image in
                self.setupImageView(with: image)
            }
        }
    }
}
