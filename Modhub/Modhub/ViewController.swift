//
//  ViewController.swift
//  Modhub
//
//  Created by Will Huynh on 5/18/20.
//  Copyright © 2020 Will Huynh. All rights reserved.
//

import UIKit

// this
var items: [String] = []

class ViewController: UIViewController {
    // this is the table view on the main screen 
    @IBOutlet weak var partsList: UITableView!

    @IBOutlet weak var NumParts: UILabel! // this is the label for the number of parts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partsList.delegate = self
        partsList.dataSource = self
        NumParts.text = String(items.count) // counting the number of parts
    }
    
}
// end of UIViewController

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // this function will handle user interaction when they select a cell
        print(items)
    }
}

extension ViewController: UITableViewDataSource {
    // needs 2 func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // this function will return the number of items in the array
        return items.count
    }
    
    // cell dequeueing function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // this is just using the template over and over just replacing the data
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}
