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
    
    var drink : Drink? {
        didSet {
            drinkIdLabel.text = drink?.id
            drinkNameLabel.text = drink?.name
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

}
