//
//  TaskViewController.swift
//  realm
//
//  Created by Елена Логинова on 26.03.2023.
//

import UIKit
import RealmSwift

class TaskViewController: UITableViewController {
    
    var taskList: TaskList!
    
    private var currentTask: Results<Task>!
    private var completeTask: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = taskList.name
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
            )
        
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        
        currentTask = taskList.tasks.filter("isComlete = false")
        completeTask = taskList.tasks.filter("isComlete = true")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTask.count : completeTask.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "CURRENT TASKS" : "COMPLETED TASKS"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let task = indexPath.section == 0 ? currentTask[indexPath.row] : completeTask[indexPath.row]
        content.text = task.name
        content.secondaryText = task.note
        cell.contentConfiguration = content
        return cell
    }

    
    // MARK: - Navigation
        
            @objc func addButtonPressed() {
                
            }
}


    //MARK: - Alert Controller

extension TaskViewController {
    
    
    
}
