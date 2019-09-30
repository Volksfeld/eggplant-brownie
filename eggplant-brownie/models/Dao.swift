//
//  Dao.swift
//  eggplant-brownie
//
//  Created by Júlio César Mussi on 29/09/19.
//  Copyright © 2019 Júlio César Mussi. All rights reserved.
//

import Foundation

class Dao {
    func saveMeals(_ meals: Array<Meal>) {
        guard let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let path = mainPath.appendingPathComponent("eggplant-brownie-meals.dados")
              
          do {
             let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
             try data.write(to: path)
             }
          catch {
            print(error.localizedDescription)
          }
    }
    
    func loadMeals() -> Array<Meal> {
        guard let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return Array<Meal>() }
        let path = mainPath.appendingPathComponent("eggplant-brownie-meals.dados")
        do {
            let data = try Data(contentsOf: path)
            if let loaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                let meals = loaded as! Array<Meal>
                return meals
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func saveItems(_ items: Array<Item>) {
        guard let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let path = mainPath.appendingPathComponent("eggplant-brownie-itens.dados")
          
          do {
             let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
             try data.write(to: path)
             } catch {
                      print(error.localizedDescription)
                     }
    }
    
    func loadItems() -> Array<Item> {
        guard let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return Array<Item>() }
        let path = mainPath.appendingPathComponent("eggplant-brownie-itens.dados")
            do {
                let data = try Data(contentsOf: path)
                if let loaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                     let items = loaded as! Array<Item>
                     return items
                }
            } catch {
                print(error.localizedDescription)
            }
        return []
    }
}
