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
var keepIndex = 0

class ViewController: UIViewController {
    // this is the table view on the main screen 
    @IBOutlet weak var partsList: UITableView!
    @IBOutlet weak var NumParts: UILabel! // this is the label for the number of parts
    @IBOutlet weak var IndividualPartsCost: UILabel! // this is the label for Individual parts
    @IBOutlet weak var TotalCost: UILabel! // this is the total cost label
    override func viewDidLoad() {
    
        super.viewDidLoad()
        partsList.delegate = self
        partsList.dataSource = self
        NumParts.text = String(items.count) // counting the number of parts
        IndividualPartsCost.text = "$0"
        TotalCost.text = "$" + String(total)
        print("the total is \(total)")
    }
    @IBAction func UpdateButton(_ sender: Any) { // need to figure out how to remove a specific price when user removes it from the tableView
        
        
    }
    
}
// end of UIViewController

//updata total button


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    // this function is for the Delegate part
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // this function will handle user interaction when they select a cell
        IndividualPartsCost.text = "$" + String(cost[indexPath.row])
      }
    
    // this is part of the data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // this function will return the number of items in the array
        return items.count
    }
    
    // cell dequeueing function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // this is just using the template over and over just replacing the data
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
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
            keepIndex = indexPath.row // keeping the index so the total cost can be updated
            partsList.beginUpdates() // this is beginning the updates for the table
            partsList.deleteRows(at: [indexPath], with: .automatic) // this is deleting a row at a specific index
            NumParts.text = String(items.count) // this is getting the number of parts when it is removed
            IndividualPartsCost.text = "$0" // resettting the text back to 0
            partsList.endUpdates()
            print("Checking to see if price is removed \(cost)")
        }
    }
    
    
}
