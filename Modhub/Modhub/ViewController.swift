//
//  ViewController.swift
//  Modhub
//
//  Created by Will Huynh on 5/18/20.
//  Copyright © 2020 Will Huynh. All rights reserved.
//

import UIKit

// this is the array that stores the parts
var items: [String] = []
var cost: [Double] = [] // this array is storing all the prices for each part
var total = 0.0
var searchArray = [String]() // temp array to filter the searches
var searching = false // flag for searching
var searchIndex = 0 // this will keep track of the searched item

class ViewController: UIViewController {
    // this is the table view on the main screen 
    @IBOutlet weak var partsList: UITableView!
    @IBOutlet weak var NumParts: UILabel! // this is the label for the number of parts
    @IBOutlet weak var IndividualPartsCost: UILabel! // this is the label for Individual parts
    @IBOutlet weak var TotalCost: UILabel! // this is the total cost label
    @IBOutlet weak var SearchBar: UISearchBar! // search bar from UI
    override func viewDidLoad() {
        SavedData() // loading saved results
        super.viewDidLoad()
        partsList.delegate = self
        partsList.dataSource = self
        NumParts.text = String(items.count) // counting the number of parts
        IndividualPartsCost.text = "$0"
        TotalCost.text = "$0"
        print("Checking items array \(items)")
        print("Checking cost array \(cost)")
        
    }
    @IBAction func UpdateButton(_ sender: Any) { // need to figure out how to remove a specific price when user removes it from the tableView
        total = sum(cost)
        TotalCost.text = "$" + String(format: "%.2f",total)
    }
    
}
// end of UIViewController


// total cost func
func sum(_ data: [Double]) -> Double{
    var total = 0.0
    var index = 0
    for _ in data{
        total += data[index]
        index += 1
    }
    return total
}

//function to load the saved data
func SavedData(){
    if let tempParts = UserDefaults.standard.object(forKey: "SavedParts"){
        items = tempParts as! [String]
    }
    
    if let tempCost = UserDefaults.standard.object(forKey: "SavedPrices"){
        cost = tempCost as! [Double]
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    // this function is for the Delegate part
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // this function will handle user interaction when they select a cell
        if searching {
            IndividualPartsCost.text = "$" + String(cost[indexPath.row])

        } else {
            IndividualPartsCost.text = "$" + String(cost[indexPath.row])
        }
        
      }
    
    // this is part of the data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // this function will return the number of items in the array
        if searching {
            return searchArray.count
        } else {
             return items.count
        }
       
    }
    
    // cell dequeueing function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // this is just using the template over and over just replacing the data
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searching {
            cell.textLabel?.text = searchArray[indexPath.row]
        }else {
            cell.textLabel?.text = items[indexPath.row]
        }
        return cell
    }
    // this function is enabling the user to edit the row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // this is the code to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // this code will execute if we are deleting something
            items.remove(at: indexPath.row) // removes from parts array
            cost.remove(at: indexPath.row) // remove from cost array
            
            partsList.beginUpdates() // this is beginning the updates for the table
            partsList.deleteRows(at: [indexPath], with: .automatic) // this is deleting a row at a specific index
            NumParts.text = String(items.count) // this is getting the number of parts when it is removed
            IndividualPartsCost.text = "$0" // resettting the text back to 0
            partsList.endUpdates()
            // updating Userdefaults and readding the object
            UserDefaults.standard.removeObject(forKey: "SavedParts")
            UserDefaults.standard.removeObject(forKey: "SavedPrices")
            UserDefaults.standard.set(items, forKey: "SavedParts")
            UserDefaults.standard.set(cost, forKey: "SavedPrices")
            UserDefaults.standard.synchronize()
            print("Now removing the selected element")
            print("Checking parts \(items)")
            print("Checking costs \(cost)")
        }
    }
}


extension ViewController: UISearchBarDelegate { // this is the search bar func
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        IndividualPartsCost.text = "$0"
        searchArray = items.filter({$0.prefix(searchText.count) == searchText}) // this will look at all prefix that the user searches for
        searching = true
        partsList.reloadData()
    }
    // cancel button function
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.endEditing(true) // gets rid of the cursor
        partsList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // when the user clicks the search button on the keyboard
        searching = false
        searchBar.endEditing(true)
    }
    
}


