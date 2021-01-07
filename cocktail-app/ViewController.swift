//
//  ViewController.swift
//  cocktail-app
//
//  Created by Philippe Le on 2020-12-31.
//

import UIKit
import Alamofire

class ViewController: UIViewController, DrinkCellDelegate {

    @IBOutlet weak var drinksTableView: UITableView!

    private var drinksViewModel : DrinksViewModel!
        
    private var dataSource : DrinksTableViewDataSource<DrinksTableViewCell,Drink>!
    
    private var drinkId : String = ""
    

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
            cell.delegate = self
            cell.drinkIdLabel.text = drink.id
            cell.drinkNameLabel.text = drink.name
            if let link = drink.thumbnailLink {
                self.fetchImage(from: link){ (imageData) in
                        if let data = imageData {
                            // referenced imageView from main thread
                            // as iOS SDK warns not to use images from
                            // a background thread
                            DispatchQueue.main.async {
                                cell.imageThumbnail.image = UIImage(data: data)
                            }
                        } else {
                            print("Error loading image");
                        }
                    }
            }
            
        })
        
        DispatchQueue.main.async {
            self.drinksTableView.dataSource = self.dataSource
            self.drinksTableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if let vc = segue.destination as! DetailedViewController && (segue.identifier == "SegueToDetailedView"){
//            vc.delegate = self
//        }
        
        if (segue.identifier == "SegueToDetailedView") {
            let vc = segue.destination as! DetailedViewController
            vc.drinkId = self.drinkId
        }
    }

//    @IBAction func enterButtonPressed(_ sender: UIButton) {
//        let listVC = ListViewController()
//        navigationController?.pushViewController(listVC, animated: true)
//    }
    func drinkCellPressed(drinkId: String) {
        print("in ViewController")
        print(drinkId)
        self.drinkId = drinkId
    }
}

