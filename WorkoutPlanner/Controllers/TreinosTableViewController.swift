//
//  TreinosTableViewController.swift
//  WorkoutPlanner
//
//  Created by VD on 20/07/2021.
//

import UIKit
import RealmSwift

class TreinosTableViewController: UITableViewController {
let realm=try! Realm()
    var treinosArray:Results<treino>?
    
    var selectedDay: Dias?{
        didSet{
            loadtreinos()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            loadtreinos()
      
    }
    //MARK:-Add novo treino
    @IBAction func addButtonTaped(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "add novo treino", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add treino", style: .default) { action in
            
            if let diaescolhido=self.selectedDay{
                do{
                try self.realm.write({
                    let novoTreino=treino()
                    novoTreino.treino=textfield.text!
                    diaescolhido.treinos.append(novoTreino)
                })
                }catch{
                    print(error)
                }
                
                }
                self.tableView.reloadData()
            
            
    
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder="Criar novo treino"
            textfield=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treinosArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "TreinoCell", for: indexPath)
        if let treino=treinosArray?[indexPath.row]{
            cell.textLabel?.text=treino.treino
            
        }
    return cell
}
    func loadtreinos(){
        treinosArray=selectedDay?.treinos.sorted(byKeyPath: "treino", ascending: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, handler in
            
            let itemtoRemove = self.treinosArray![indexPath.row]
            
            do{
                try self.realm.write({
                    self.realm.delete(itemtoRemove)
                })
            }catch{
                print(error)
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}
