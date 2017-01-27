//
//  BeastedTableViewController.swift
//  BeastBlackBelt
//
//  Created by Calvin Nguyen on 1/27/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

class BeastedTableViewController: UITableViewController {
    
    var beasted_items: [BeastItem] = []
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print("BEASTED VIEW LOADED")
        
        fetchBeastedItems()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beastedCell") as! BeastedCell
        
        cell.itemLabel.text = beasted_items[indexPath.row].name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d"
        let my_date = formatter.string(from: beasted_items[indexPath.row].created_date as! Date)
        
        cell.dateLabel.text = my_date
        
        //        cell.memImage.contentMode = .scaleAspectFit
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasted_items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // populate the items of the List to display on screen
    func fetchBeastedItems(){
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BeastItem")
        let beastSort = NSSortDescriptor(key: "name", ascending: true)
        userRequest.sortDescriptors = [beastSort]
        userRequest.predicate = NSPredicate(format: "is_done == %@", NSNumber(booleanLiteral: true))
        do {
            let results = try managedObjectContext.fetch(userRequest)
            beasted_items = results as! [BeastItem]
        } catch {
            print("\(error)")
        }
        
        print(beasted_items.count)
        for item in beasted_items{
            print("current beasted items:")
            print(item.name)
            print(item.is_done)
        }

    }


    
    
}
