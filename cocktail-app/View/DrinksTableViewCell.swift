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
    
    var drink : Drink? {
        didSet {
            drinkIdLabel.text = drink?.id
            drinkNameLabel.text = drink?.name
            imageThumbnail.contentMode = .scaleAspectFit
            if let link = drink?.thumbnailLink {
                fetchImage(from: link){ (imageData) in
                        if let data = imageData {
                            // referenced imageView from main thread
                            // as iOS SDK warns not to use images from
                            // a background thread
                            DispatchQueue.main.async {
                                self.imageThumbnail.image = UIImage(data: data)
                            }
                        } else {
                                // show as an alert if you want to
                            print("Error loading image");
                        }
                    }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
