//
//  ToBeastCell.swift
//  BeastBlackBelt
//
//  Created by Calvin Nguyen on 1/27/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit

class ToBeastCell: UITableViewCell{
    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBAction func beastButtonClicked(_ sender: UIButton) {
    }
    weak var delegate: AddBeastItemTableViewControllerDelegate?

}
