//
//  partsViewController.swift
//  Modhub
//
//  Created by Will Huynh on 5/25/20.
//  Copyright © 2020 Will Huynh. All rights reserved.
//

import UIKit

class partsViewController: UIViewController {

    var ViewController: ViewController? // allows me to use methods from ViewController class from the main view
    // this is the textfield for partsName
    @IBOutlet weak var Partname: UITextField!
    // this is the price textfield
    @IBOutlet weak var Price: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var name = "" // initialize a variable that stores the part name
    var price  = "" // this is a variable that stores the price
    
    // this is the done button for the adding parts

    @IBAction func done(_ sender: UIButton) {
        if Partname.text == "" { // error checking if the string is empty
           let alert =  UIAlertController(title: "Error!", message: "Part name must be filled out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else{
            // if it is not an empty string, then continue
            items.append(Partname.text!)
            print("I am adding shit to the items array")
            print(items)
        }

    }
    
    // this is the backbutton
    @IBAction func backButton(_ sender: Any) {
        // need to clear the textfield if the user changes their mind
        Partname.text = ""
        Price.text = ""
    }
    
    
    
    
    
    
}
