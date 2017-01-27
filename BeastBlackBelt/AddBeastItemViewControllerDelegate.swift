//
//  AddBeastItemViewControllerDelegate.swift
//  BeastBlackBelt
//
//  Created by Calvin Nguyen on 1/27/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit

protocol AddBeastItemTableViewControllerDelegate: class {
    
    func itemAdded(by controller: AddBeastItemViewController, with title: String)
    
    func itemEdited(by controller: AddBeastItemViewController, with title: String, on item: BeastItem)
    
    func cancelButtonPressed(by controller: AddBeastItemViewController)

}
