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

    var delegate : AddAMealDelegate?
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
    
    func convertToInt(_ text: String?) -> Int? {
      if let number = text {
        return Int(number)
      }
      return nil
    }
    
    func getMealFromForm() -> Meal? {
        if let name = nameField?.text {
            if let happiness = convertToInt(happinessField?.text) {
                return Meal(name: name, happiness: happiness, items: selected)
            }
        }
        return nil;
    }
    
    @IBAction func add() {
      if let meal = getMealFromForm() {
            if let meals = mealsTable {
                meals.add(meal)
                if let navigation = navigationController {
                    navigation.popViewController(animated: true)
                } else {
                    Alert(controller: self).show(message: "Unable to go back, but the meal was added.")
                }
                return
            }
        }
        Alert(controller: self).show()
    }
}

