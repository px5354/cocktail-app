//
//  DrinksTableViewDataSource.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-04.
//

import Foundation
import UIKit

class DrinksTableViewDataSource: NSObject, UITableViewDataSource {
    
    private weak var viewModel: DrinksViewModel?
    private var searchController: UISearchController?
    
    required init(withViewModel viewModel: DrinksViewModel, withSearchController searchController: UISearchController) {
        self.viewModel = viewModel
        self.searchController = searchController
    }

    var isSearching: Bool {
        return searchController?.isActive ?? false && !(searchController?.searchBar.text?.isEmpty ?? true)
    }
    
    var cellIdentifier: String {
        return viewModel?.cellIdentifier ?? ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return viewModel?.numberOfFilteredDrinks ?? 0
        }
        
        return viewModel?.numberOfDrinks ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DrinksTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        }
        // TODO: simplify logic and fix getImage
        if isSearching {
            if let drink = viewModel?.filteredDrink(at: indexPath.row) {
                cell.setupView(with: drink)
            }

            viewModel?.getImage(at: indexPath.row) { image in
                cell.setupImageView(with: image)
            }
        } else {
            if let drink = viewModel?.drink(at: indexPath.row) {
                cell.setupView(with: drink)
            }

            viewModel?.getImage(at: indexPath.row) { image in
                cell.setupImageView(with: image)
            }
        }
        
        return cell
    }
}
