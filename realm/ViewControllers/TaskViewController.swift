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
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = indexPath.section == 0 ? currentTask[indexPath.row] : completeTask[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [unowned self] _, _, isDone in
            showAlert(with: task) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
            
        let title = indexPath.section == 0 ? "Done" : "Undone"
        
        let doneAction = UIContextualAction(style: .normal, title: title) { [weak self] _, _, isDone in
            StorageManager.shared.done(task)
            
            let currentTaskIndex = IndexPath(
                row: self?.currentTask.index(of: task) ?? 0,
                section: 0
            )
            let completedTaskIndex = IndexPath(
                row: self?.completeTask.index(of: task) ?? 0,
                section: 1
            )
            let destinationIndexRow = indexPath.section == 0 ? completedTaskIndex : currentTaskIndex
            tableView.moveRow(at: indexPath, to: destinationIndexRow)
            
            isDone(true)
        }
            
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = indexPath.section == 0 ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }

    
    // MARK: - Navigation
        
    @objc func addButtonPressed() {
         showAlert()
    }
}


    //MARK: - Alert Controller

extension TaskViewController {
    
    func showAlert(with task: Task? = nil, completion: (() -> Void)? = nil) {
        let title = task == nil ? "New task" : "Edit task"
        let alert = UIAlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
        alert.action(with: task) { [weak self] name, note in
            if let task = task, let completion = completion {
                StorageManager.shared.edit(task, newName: name, newNote: note)
                completion()
            } else {
                self?.save(task: name, withNote: note)
            }
        }
        
        present(alert, animated: true)
    }
    
    private func save(task: String, withNote note: String) {
        StorageManager.shared.save(task, withNote: note, to: taskList) { task in
            let rowIndex = IndexPath(row: currentTask.index(of: task) ?? 0, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
        }
    }
}
