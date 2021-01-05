//
//  ViewController.swift
//  cocktail-app
//
//  Created by Philippe Le on 2020-12-31.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var drinksTableView: UITableView!

    private var drinksViewModel : DrinksViewModel!
        
    private var dataSource : DrinksTableViewDataSource<DrinksTableViewCell,Drink>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.drinksViewModel = DrinksViewModel()
        self.drinksViewModel.bindDrinksViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        self.dataSource = DrinksTableViewDataSource(cellIdentifier: "DrinksTableViewCell", items: self.drinksViewModel.drinksData, configureCell: { (cell, drink) in
            cell.drinkIdLabel.text = drink.id
            cell.drinkNameLabel.text = drink.name
        })
        
        DispatchQueue.main.async {
            self.drinksTableView.dataSource = self.dataSource
            self.drinksTableView.reloadData()
            print(self.drinksViewModel.drinksData ?? "empty")
        }
    }

//    @IBAction func enterButtonPressed(_ sender: UIButton) {
//        let listVC = ListViewController()
//        navigationController?.pushViewController(listVC, animated: true)
//    }
    
}

