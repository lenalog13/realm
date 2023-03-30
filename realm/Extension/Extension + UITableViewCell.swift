//
//  Extension + UITableViewCell.swift
//  realm
//
//  Created by Елена Логинова on 30.03.2023.
//

import UIKit

extension UITableViewCell {
    func configure( with taskList: TaskList) {
        
        var content = defaultContentConfiguration()
        
        content.text = taskList.name
        let count = countOfTasks(taskList)
        if !taskList.tasks.isEmpty && count == 0 {
            content.secondaryText = nil
            accessoryType = .checkmark
        } else {
            content.secondaryText = "\(count)"
            accessoryType = .none
        }
        contentConfiguration = content
    }
    
    private func countOfTasks(_ taskList: TaskList) -> Int {
        var count = 0
        for task in taskList.tasks {
            if task.isComlete == false {
                count += 1
            }
        }
        return count
    }
}
