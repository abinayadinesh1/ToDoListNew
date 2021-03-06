//
//  ToDoTableViewController.swift
//  ToDoListNew
//
//  Created by Abinaya Dinesh on 6/9/20.
//  Copyright © 2020 Abinaya Dinesh. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var toDos : [ToDoCD] = []
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    func getToDos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD]{
                    toDos = coreDataToDos
                    tableView.reloadData()
                
                
            }
        }
        
    }

    // MARK: - Table view data source
//if toDo.count , then update the image to a new image
    //counter = 5
    //image corresponding to each number of toDos
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDos.count
    }

/* we don't need this anymore from when we hardcoded it
    func createToDos() -> [ToDo]{
        
        let swift = ToDo()
        swift.name = "Learn Swift"
        swift.important = true
        
        let dog = ToDo()
        dog.name = "Walk the Dog"
        
        return[swift, dog]
        
        
    }
*/
override func viewWillAppear(_ animated: Bool) {
    getToDos()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

      let toDo = toDos[indexPath.row]
        
    if let name = toDo.name{
      if toDo.important {
        cell.textLabel?.text = "❗️" + name
      } else {
        cell.textLabel?.text = toDo.name
      }
        }
      return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      // this gives us a single ToDo
      let toDo = toDos[indexPath.row]

      performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let plantVC = segue.destination as? HomePageViewController{
            plantVC.previousVC = self
        }
      if let addVC = segue.destination as? AddToDoViewController {
        addVC.previousVC = self
      }
        
        if let completeVC = segue.destination as? CompletePageViewController{
            if let toDo = sender as? ToDoCD{
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }

    


}
