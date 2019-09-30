import Foundation
import UIKit

class Meal : NSObject, NSCoding {
    let name:String
    let happiness:Int
    let items:Array<Item>
    
    init(name:String, happiness:Int, items: Array<Item> = []){
        self.name = name
        self.happiness = happiness
        self.items = items
    }
    
    required init? (coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.happiness = aDecoder.decodeInteger(forKey: "happiness")
        self.items = aDecoder.decodeObject(forKey: "items") as! Array<Item>
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(happiness, forKey: "happiness")
        aCoder.encode(items, forKey: "items")
    }
    
    func allCalories() -> Double {
        var total:Double = 0
        for item in items {
            total += item.calories
        }
        return total
    }
    
    func details() -> String {
        var message = "Happiness: \(self.happiness)"
        for item in self.items {
            message += "\n \(item.name) - Calories = \(item.calories)"
        }
        return message
    }
}
