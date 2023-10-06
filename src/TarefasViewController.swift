//
//  ViewController.swift
//  ToDoLiST
//
//  Created by Student on 06/12/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tarefas"
        tableView.delegate = self
        tableView.dataSource = self
        
        // setup
        
        if  !UserDefaults().bool(forKey: "setup"){
            
            UserDefaults().set(true, forKey:"setup")
            UserDefaults().set(0, forKey:"count")

        }
        
        updateTasks()

    }
    
    
    func updateTasks(){
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count{
            
            if  let task = UserDefaults().value(forKey: "task_\(x + 1)") as? String{
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func didTapAdd (){
        // quando clicar no adcionar ira p outra view
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "Nova tarefa"
        vc.update = {
            DispatchQueue.main.async{
                 self.updateTasks()
            }
           
        }
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       // let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        //       vc.title = "Nova tarefa"
            //   vc.task = tasks[indexPath.row]
          //     navigationController?.pushViewController(vc, animated: true)
           }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        return.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            tableView.beginUpdates()
            tasks.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    
}

