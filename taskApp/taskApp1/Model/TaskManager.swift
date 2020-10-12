//
//  TaskManager.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/10/09.
//  Copyright © 2020 yuuki. All rights reserved.
//

import Foundation

class TaskManager {
    static func saveData(task:[Task]){
        let data = try? JSONEncoder().encode(task)
        UserDefaults.standard.set(data, forKey: "task")
    }
    static func getData() -> [Task]{
        
        guard let datas = UserDefaults.standard.data(forKey: "task")else{
            return []
        }
        let taskData = try? JSONDecoder().decode([Task].self, from: datas)
        
        return taskData ?? []
    }
}
