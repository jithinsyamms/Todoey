//
//  ViewController.swift
//  Todoey
//
//  Created by Jithin on 08/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark -Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alertController = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let item = Item()
            item.title = textField.text!
            self.itemArray.append(item)
            self.saveData()
        }
        alertController.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new item"
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK -Data Manupulation
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: self.itemFilePath!)
        }
        catch{
          print("Encoder Error")
        }
        tableView.reloadData()
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: itemFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
            }
        }
        
    }
}

