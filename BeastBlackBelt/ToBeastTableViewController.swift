//
//  ViewController.swift
//  BeastBlackBelt
//
//  Created by Calvin Nguyen on 1/27/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ToBeastTableViewController: UITableViewController, AddBeastItemTableViewControllerDelegate {
    
    var beast_items: [BeastItem] = []
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItems()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toBeastCell") as! ToBeastCell

        cell.itemLabel.text = beast_items[indexPath.row].name
        cell.delegate = self
        
        
        //        cell.memImage.contentMode = .scaleAspectFit
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beast_items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // removal of items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            managedObjectContext.delete(beast_items[indexPath.row])
            
            if managedObjectContext.hasChanges {
                do
                {
                    try managedObjectContext.save()
                    print("Success Deleting an item to core data")
                } catch
                {
                    print("\(error)")
                }
            }
            
            
            beast_items.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
        
    }
    
    
    
    @IBAction func beastButtonClicked(_ sender: UIButton) {
        print("BEAST CLICKED")
        if let this_button = sender as? UIButton{
            let indexPath: IndexPath
            let cell = this_button.superview?.superview as! UITableViewCell
            indexPath = tableView.indexPath(for: cell)!
            let item = beast_items[indexPath.row] 
            item.is_done = true
            
            if managedObjectContext.hasChanges {
                do
                {
                    try managedObjectContext.save()
                    print("Success Beasting an item to core data")
                } catch
                {
                    print("\(error)")
                }
            }
            fetchAllItems()
            tableView.reloadData()

            
            print(indexPath)
            
        }

    }
    
    
    
    // prepare the segue to specify as delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let addItemTableController = navigationController.topViewController as! AddBeastItemViewController
        addItemTableController.delegate = self
        
        if let this_sender = sender{
//            print(sender)
            if this_sender is ToBeastCell
            {
                print("EDITING")
                let cell = this_sender
                let indexPath = tableView.indexPath(for: cell as! ToBeastCell)!
                // pass the item to edit to Add Item table view for
                // user to edit
                let item = beast_items[indexPath.row]
                addItemTableController.edit_item = item
            }
            
//            else if this_sender is UIButton{
//                let beastedTableController = navigationController.topViewController as! BeastedTableViewController
////                beastedTableController.delegate = self
//                let indexPath: IndexPath
//                if let this_button = sender as? UIButton{
//                    let cell = this_button.superview?.superview as! UITableViewCell
//                    indexPath = tableView.indexPath(for: cell)!
//                    print(indexPath)
//
//                }
//                
//            }

            
        }
        
        
    }

    
    func itemAdded(by controller: AddBeastItemViewController, with title: String){
        
        let list = NSEntityDescription.insertNewObject(forEntityName: "BeastItem", into: managedObjectContext) as! BeastItem
        
        list.name = title
        list.is_done = false
        list.created_date = Date() as NSDate?

        
        // need to commit the changes first to record data
        if managedObjectContext.hasChanges {
            do
            {
                try managedObjectContext.save()
                print("Success Adding an item to core data")
            } catch
            {
                print("\(error)")
            }
        }
        
        print(list.created_date)
        print(list.is_done)
        
        fetchAllItems()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func itemEdited(by controller: AddBeastItemViewController, with title: String, on item: BeastItem){
        
        item.name = title
        
        // need to commit the changes first to record data
        if managedObjectContext.hasChanges {
            do
            {
                try managedObjectContext.save()
                print("Success Editing an item to core data")
            } catch
            {
                print("\(error)")
            }
        }
        
        
        fetchAllItems()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)

        
    }
    
    func cancelButtonPressed(by controller: AddBeastItemViewController){
        dismiss(animated: true, completion: nil)
        
    }

    
    
    
    // populate the items of the List to display on screen
    func fetchAllItems(){

        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BeastItem")
        let beastSort = NSSortDescriptor(key: "name", ascending: true)
        userRequest.sortDescriptors = [beastSort]
        userRequest.predicate = NSPredicate(format: "is_done == %@", NSNumber(booleanLiteral: false))
        do {
            let results = try managedObjectContext.fetch(userRequest)
            beast_items = results as! [BeastItem]
        } catch {
            print("\(error)")
        }

//        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BeastItem")
//        do {
//            let results = try managedObjectContext.fetch(userRequest)
//            beast_items = results as! [BeastItem]
//        } catch {
//            print("\(error)")
//        }

    }

}

