//
//  CustomCell.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/03.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
protocol TaskTableViewCellDelegate {
    func alertDisplay(title:String,date:String,indexEdit:Int)
}
class TaskTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var task:[Task]!
    
    var index: Int!
    
    var delegate:TaskTableViewCellDelegate?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heartButtondisp: UIButton!
    @IBOutlet weak var celllabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(task: [Task], index: Int) {
        
        guard let isFavorite = task[index].isFavorite as? Bool else {
            return
        }
        
        if isFavorite {
            heartButtondisp.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButtondisp.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        celllabel.text = task[index].title
        dateLabel.text = task[index].date
        //
        self.task = task
        self.index = index
    }
    @IBAction func editTask(_ sender: Any) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let tlVC = storyboard.instantiateViewController(withIdentifier: "TaskList") as! TaskListViewController*/
        delegate?.alertDisplay(title: task[index].title, date: task[index].date,indexEdit:index)
        
    }
    
    @IBAction func heartButton(_ sender: Any) {
        
        guard let isFavorite = task[index].isFavorite as? Bool else {
            return
        }
        
        if isFavorite {
            heartButtondisp.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            heartButtondisp.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        let taskData = TaskManager.getData()
        taskData[index].isFavorite = !isFavorite
        
        TaskManager.saveData(task: taskData )
        
        //var saveData = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []
        //saveData[index]["isFavorite"] = !isFavorite
        
        //UserDefaults.standard.set(saveData, forKey: "tasks")
        //なんで書いてあるのかわからない。
        task[index].isFavorite = !isFavorite
        
    }
}


