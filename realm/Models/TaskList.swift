//
//  TaskList.swift
//  realm
//
//  Created by Елена Логинова on 26.03.2023.
//

import Foundation
import RealmSwift


class TaskList: Object {
    @Persisted var name = ""
    @Persisted var date = Date()
    @Persisted var task = List<Task>()
}

class Task: Object {
    @Persisted var name = ""
    @Persisted var note = ""
    @Persisted var date = Date()
    @Persisted var isComlete = false
}
