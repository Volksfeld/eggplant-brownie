import Foundation
import UIKit

class Item : Equatable {
    var name:String
    var calories:Double
    
    init(name:String, calories:Double) {
        self.name = name
        self.calories = calories
    }
    
    static func ==(first: Item, second: Item) -> Bool {
        return first.name == second.name && first.calories == second.calories
    }
}



	
