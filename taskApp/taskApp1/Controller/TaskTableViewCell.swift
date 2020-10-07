//
//  CustomCell.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/03.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit


class TaskTableViewCell: UITableViewCell {
    
    var task:[Task]!
    
    var index: Int!
    
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
    @IBAction func apeendTask(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultButton: UIAlertAction = UIAlertAction(title: "ボタン", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
            // ボタンが押された時のコード
        })
        
        let cancelButton: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {(action: UIAlertAction!) -> Void in
            // ボタンが押された時のコード
            
        })
        
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = "テキストボックス"
        })
        
        alert.addAction(defaultButton)
        alert.addAction(cancelButton)
        
        // delegate!.present(alert, animated: true, completion: nil)
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
        
        guard let datas = UserDefaults.standard.data(forKey: "task")else{
            return
        }
        let taskData = try? JSONDecoder().decode([Task].self, from: datas)
        taskData![index].isFavorite = !isFavorite
        print(taskData)
        saveData(task: taskData ?? [])
        //var saveData = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []
        //saveData[index]["isFavorite"] = !isFavorite
        
        //UserDefaults.standard.set(saveData, forKey: "tasks")
        //なんで書いてあるのかわからない。
        task[index].isFavorite = !isFavorite
        
        
    }
    func saveData(task:[Task]){
        let data = try? JSONEncoder().encode(task)
        UserDefaults.standard.set(data, forKey: "task")
    }
}


