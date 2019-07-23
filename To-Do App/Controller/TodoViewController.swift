//
//  ViewController.swift
//  To-Do App
//
//  Created by Lalith Manukonda on 7/18/19.
//  Copyright © 2019 Lalith Manukonda. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController{
    
    var needToGrindArray = [Items]()
    //We are grabbing the persistant container and its context - which is the temporary area where our app can talk to our SQL backend
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadData()
    }
    
    // This function is to determine how many rows that we need to have in our tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return needToGrindArray.count
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = needToGrindArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item.nameOfItem
        
       // the following code is make the checkmark appear or not. We will know if it is done or not based on the didSelectRowAt funcion where we set the completion property
        
        cell.accessoryType = item.completion == true ? .checkmark : .none // replaced the if/else statement that we had for all of this. If the cell completion is true, get a checkmark, if not have none
        
        
        return cell
        
        // Here is what is going on in the function above:
        
        /*
         1. the first tableView and this second function are the dataSource for the tableview.
             ->They allow us to specify what the cells should display and how many rows they need to have.
         2. The code for the second function that we are using to get stuff to show up on the tableView isn't that hard.
            -> we are creating a new cell and making it a reusable cell and telling the code which tableview it is a part of.
            -> Then we are chaing the text label of the cell - as seen by the textLable?.text to show up the things that are in teh needToGrindArray and finally we are just retruring that cell
         
        */
    }
    
    // This function tells the delegate that row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       needToGrindArray[indexPath.row].completion = !needToGrindArray[indexPath.row].completion
        
//        context.delete(needToGrindArray[indexPath.row])
//        needToGrindArray.remove(at: indexPath.row)
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var itemAlertHolder = UITextField()
        
        let itemAlert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
    

        let itemAction = UIAlertAction(title: "Add To-Do", style: .default) { (action) in
            // Here is where we put the code of what happens when the add button is pressed
            
            // we are creating a new ItemsDataModel because the append code itself will not working so we are setting the title into the newItem and then appending it to the thing. Since it is already false, the checkmark will not be toggled.
            
            // This newItem that we have created is in the context area, which is a tool that is used to talk to the SQLDatabase
            let newItem = Items(context: self.context)
            newItem.nameOfItem = itemAlertHolder.text!
            newItem.completion = false
            self.needToGrindArray.append(newItem)
            self.saveItems()
            
        }
        
        itemAlert.addTextField { (itemAlertTextField) in
            itemAlertTextField.placeholder = "Create a new To-Do"
            itemAlertHolder = itemAlertTextField
        }
        
        
       
        itemAlert.addAction(itemAction)
        present(itemAlert, animated: true, completion: nil)
    }
    
    func saveItems () {
        do{
           try context.save()
        }
        catch{
            print("We had this error saving the data \(error)")
        }
        tableView.reloadData()
    }

    func loadData () {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        do{
            needToGrindArray = try context.fetch(request)
        }
        catch{
            print("Had this error fetching the data : \(error)")
        }
        
    }

}

