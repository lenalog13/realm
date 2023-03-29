//
//  StorageManager.swift
//  realm
//
//  Created by Елена Логинова on 26.03.2023.
//

import Foundation
import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    
    // MARK: - Task List
    
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(_ taskList: String, completion: (TaskList) -> Void) {
        write {
            let taskList = TaskList(value: [taskList])
            realm.add(taskList)
            completion(taskList)
        }
    }
    
    func delete(_ taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func edit(_ taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    func done(_ taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComlete")
        }
    }

    
    
    // MARK: - Tasks
    
    func save(_ task: Task, to taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    func save(_ task: String, withNote: String, to taskList: TaskList, completion: (Task) -> Void) {
        write {
            let task = Task(value: [task, withNote])
            taskList.tasks.append(task)
            completion(task)
        }
    }
    
    func delete(_ task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func edit(_ task: Task, newName: String, newNote: String) {
        write {
            task.name = newName
            task.note = newNote
        }
    }
    
    func done(_ task: Task) {
        write {
            task.isComlete.toggle()
        }
    }
    
    
    //MARK: - Private Func
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
}
