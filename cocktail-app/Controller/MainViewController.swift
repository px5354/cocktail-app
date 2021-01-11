//
//  ViewController.swift
//  cocktail-app
//
//  Created by Philippe Le on 2020-12-31.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var drinksTableView: UITableView!
    
    private var drinksViewModel: DrinksViewModel = DrinksViewModel()
    private var dataSource: DrinksTableViewDataSource?
    private var searchController: UISearchController = UISearchController(searchResultsController: nil)
    private var drinkId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchController()
        initializeDataSource()
        fetchDrinks()
    }
    
    func initializeDataSource() {
        dataSource = DrinksTableViewDataSource(withViewModel: drinksViewModel, withSearchController: searchController)
        drinksTableView.dataSource = dataSource
        drinksTableView.delegate = self
    }
    
    func initializeSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a drink"
        navigationItem.searchController = searchController
    }
    
    func fetchDrinks() {
        drinksViewModel.getOrdinaryDrinks {
            DispatchQueue.main.async {
                self.drinksTableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let drinkId = drinksViewModel.drinkFromCurrentData(at: indexPath.row)?.id else {
            print("Error getting drink id")
            return
        }

        let vc = DetailedViewController()
        vc.drinkId = drinkId
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        drinksViewModel.filterDrinks(with: searchText)
        drinksTableView.reloadData()
    }
    
}
