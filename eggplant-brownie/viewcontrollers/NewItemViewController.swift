//
//  NewItemViewController.swift
//  eggplant-brownie
//
//  Created by Júlio César Mussi on 20/09/19.
//  Copyright © 2019 Júlio César Mussi. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField?
    @IBOutlet var caloriesField: UITextField?
    var delegate: AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate) {
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func addNewItem() {
        let name = nameField!.text
        let calories = Double(caloriesField!.text!)
        
        if (name == nil || calories == nil || delegate == nil) {
            return
        }
        
        let item = Item(name: name!, calories: calories!)
        delegate!.add(item)
        
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }


}
