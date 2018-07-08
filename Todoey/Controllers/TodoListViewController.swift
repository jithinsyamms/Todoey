//
//  ViewController.swift
//  Todoey
//
//  Created by Jithin on 08/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var defaults = UserDefaults.standard
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var item = Item()
        item.title = "Find Mike"
        itemArray.append(item)
        
        item = Item()
        item.title = "Buy Eggs"
        itemArray.append(item)
        
        item = Item()
        item.title = "Destroy Avengers"
        itemArray.append(item)
        
    }

    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark -Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alertController = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
//            self.itemArray.append(textField.text!)
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alertController.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new item"
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}

