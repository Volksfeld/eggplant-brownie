//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Júlio César Mussi on 26/06/19.
//  Copyright © 2019 Júlio César Mussi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var happinessField: UITextField!
    @IBOutlet var tableView: UITableView?
    
    var mealsTable: AddAMealDelegate?
    var items = [Item(name: "Eggplant", calories: 10),
                 Item(name: "Brownie", calories: 10),
                 Item(name: "Zucchini", calories: 10),
                 Item(name: "Muffin", calories: 10),
                 Item(name: "Coconut oil", calories: 500),
                 Item(name: "Chocolate frosting", calories: 1000),
                 Item(name: "Chocolate chip", calories: 1000)]
    var selected : Array<Item> = []
    
    func add(_ item: Item) {
        items.append(item)
        if let table = tableView {
            table.reloadData()
        } else {
            Alert(controller: self).show(message: "Unable to reload the itens table")
        }
    }
    
    override func viewDidLoad() {
       let newItemButton =  UIBarButtonItem(title: "new item", style: UIBarButtonItem.Style.plain,
                                            target: self, action: #selector(showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
    }
    
    @objc func showNewItem() {
        let newItem = NewItemViewController(delegate: self)
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if (cell.accessoryType == UITableViewCell.AccessoryType.none){
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            let item = items[indexPath.row]
            selected.append(item)
            } else {
                cell.accessoryType = UITableViewCell.AccessoryType.none
                let item = items[indexPath.row]
                let position = selected.firstIndex(of: item)
                selected.remove(at: position!)
            }
        }
    }
    
    @IBAction func add() {
        if(nameField == nil || happinessField == nil) {
            return
        }
        
        let name:String = nameField!.text!
        if let happiness = Int(happinessField!.text!) {
            let meal = Meal(name: name, happiness: happiness, items: selected)
            
            print("Eaten \(meal.name), with happiness \(meal.happiness) and itens: \(meal.items)")
            mealsTable!.add(meal)
            
            
            if let navigation = navigationController {
                navigation.popViewController(animated: true)
            }
        }
    }
}

