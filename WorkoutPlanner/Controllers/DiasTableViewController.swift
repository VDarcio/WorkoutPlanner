//
//  DiasTableViewController.swift
//  WorkoutPlanner
//
//  Created by VD on 20/07/2021.
//

import UIKit
import RealmSwift

class DiasTableViewController: UITableViewController {

    let realm = try! Realm()
    var diasArray:Results<Dias>?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            load()
      
    }

    //MARK:-Add novo dia
    @IBAction func addButtonTaped(_ sender: UIBarButtonItem) {
        var textfield=UITextField()
        let alert=UIAlertController(title: "add novo dia", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Dia", style: .default) { action in
            
        let novodia=Dias()
            novodia.dia=textfield.text!
            
            self.save(com: novodia)
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder="Criar novo treino"
            textfield=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

}
    //MARK:-TableviewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diasArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "DiasCell", for: indexPath)
       
        cell.textLabel?.text=diasArray?[indexPath.row].dia ?? "sem dias"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, handler in
            
            let itemtoRemove = self.diasArray![indexPath.row]
            
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
    
    
    
    func save (com dia:Dias){
        try! realm.write({
            realm.add(dia)
        })
        self.tableView.reloadData()
    }
    
    func load(){
        diasArray=realm.objects(Dias.self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToTreinos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TreinosTableViewController
        if let indexpath=tableView.indexPathForSelectedRow{
            destinationVC.selectedDay=diasArray?[indexpath.row]
        }
    }
    
    
    
    
    
    
}
