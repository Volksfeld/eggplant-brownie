import UIKit

class MealsTableViewController : UITableViewController, AddAMealDelegate {
    var meals = [Meal(name: "Eggplant Brownie", happiness: 5),
                 Meal(name: "Zucchini Muffin", happiness: 3)]
    
    func add(_ meal:Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addMeal"){
        let view = segue.destination as! ViewController
        view.mealsTable = self
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal.name
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
         cell.addGestureRecognizer(recognizer)
        return cell
    }
    
    @objc func showDetails(recognizer: UILongPressGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.began) {
        let cell = recognizer.view as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let row = indexPath.row
                let meal = meals[row]
                func removeSelected(action: UIAlertAction) {
                    print("Removing")
                    meals.remove(at: row)
                    tableView.reloadData()
                }
                let details =  UIAlertController(title: meal.name,
                                                 message: meal.details(),
                    preferredStyle: UIAlertController.Style.alert)
                
                let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: removeSelected)
                details.addAction(remove)
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                details.addAction(ok)
            
                present(details, animated: true)
                print("Long Press: \(meal.name)")
            }
        }
    }
}
