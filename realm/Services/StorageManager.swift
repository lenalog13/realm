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
        
    }
    
    
    // MARK: - Tasks
    
    
    
    
}
