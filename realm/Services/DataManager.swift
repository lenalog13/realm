//
//  DataManager.swift
//  realm
//
//  Created by Елена Логинова on 26.03.2023.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
         
            let shoppingList = TaskList()
            shoppingList.name = "Shopping List"
            
            let milk = Task()
            milk.name = "milk"
            milk.note = "2L"
            
            let bread = Task(value: ["bread", "", Date(), true])
            let apples = Task(value: ["name": "apples", "note": "2Kg"])
            
            shoppingList.tasks.append(milk)
            shoppingList.tasks.append(bread)
            shoppingList.tasks.append(apples)
            
            
            let moviesList = TaskList(
                value: [
                    "Movies List",
                    Date(),
                    [
                        ["Best film ever"],
                        ["The best of the best", "Must have", Date(), true]
                    ]
                ]
            )
            
            DispatchQueue.main.async {
                StorageManager.shared.save([shoppingList, moviesList])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
}
