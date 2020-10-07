//
//  Task.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/26.
//  Copyright © 2020 yuuki. All rights reserved.
//

import Foundation

class Task :Codable{
    var title:String
    var date:String
    var isFavorite:Bool
    
    init(title:String,date:String,isFavorite:Bool) {
        self.title = title
        self.date = date
        self.isFavorite = isFavorite
    }
    static var saveTasks:[Task] = [Task(title: "a", date: "w", isFavorite: false),
                                   Task(title: "a", date: "w", isFavorite: false),
                                   Task(title: "a", date: "w", isFavorite: false)]
    

}



  
  
