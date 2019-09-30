import UIKit

class MealsTableViewController : UITableViewController, AddAMealDelegate {
    var meals = [Meal(name: "Eggplant Brownie", happiness: 5),
                 Meal(name: "Zucchini Muffin", happiness: 3)]
    
    override func viewDidLoad() {

        guard let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let path = mainPath.appendingPathComponent("eggplant-brownie-meals.dados")

        do {
            let data = try Data(contentsOf: path)

            if let loaded = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                 meals = loaded as! Array<Meal>
            }
        } catch {
            print(error.localizedDescription)
        }


    }
    
    func add(_ meal:Meal) {
        meals.append(meal)
        
        guard let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
               let path = mainPath.appendingPathComponent("eggplant-brownie-meals.dados")
        
        do {
           let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
           try data.write(to: path)
           }
            catch {
                    print(error.localizedDescription)
                   }
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
                
                RemoveMealController(controller: self).show(meal, handler: { action in
                    self.meals.remove(at: row)
                    self.tableView.reloadData()
                })
            }
        }
    }
}
