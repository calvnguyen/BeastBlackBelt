//
//  AddBeastItemViewController.swift
//  BeastBlackBelt
//
//  Created by Calvin Nguyen on 1/27/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit

class AddBeastItemViewController: UIViewController{
    @IBOutlet weak var addItemLabel: UITextField!
    
    var delegate: AddBeastItemTableViewControllerDelegate?
    
    var edit_item: BeastItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let this_item = edit_item{
            addItemLabel.text = this_item.name
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancellButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        if let this_description = addItemLabel.text{
            
            
            if let this_item = edit_item{
                delegate?.itemEdited(by: self, with: this_description, on: this_item)
            }
            else{
                delegate?.itemAdded(by: self, with: this_description)
                
            }
        }

        
        
    }
    
    
    
}
