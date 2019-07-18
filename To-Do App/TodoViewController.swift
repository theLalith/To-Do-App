//
//  ViewController.swift
//  To-Do App
//
//  Created by Lalith Manukonda on 7/18/19.
//  Copyright © 2019 Lalith Manukonda. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController{
    
    let needToGrindArray = ["Coding", "Calclus", "Other stuff"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // This function is to determine how many rows that we need to have in our tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return needToGrindArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = needToGrindArray[indexPath.row]
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
        //let goingToPrint = indexPath.row
        //print("\(needToGrindArray[goingToPrint])")
        // instead of that i could also done: print(needToGrindArry[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    


}

