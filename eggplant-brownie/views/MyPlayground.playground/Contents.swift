import UIKit

class Meal {
    var name:String
    var happiness:Int
    
    init(name:String, happiness:Int) {
        self.name = name
        self.happiness = happiness
    }
    
   
}

var brownie = Meal(name:"Eggplant Brownie", happiness:5)
    
    print (brownie.name);
