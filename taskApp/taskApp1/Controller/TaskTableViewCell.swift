//
//  CustomCell.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/03.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
protocol TaskTableViewCellDelegate {
    func alertDisplay()
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
    @IBAction func apeendTask(_ sender: Any) {
        
        delegate?.alertDisplay()
        
        
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
    
    /*let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle:  .alert)
     //タイトル変える時
     alert.addTextField { (celllabel) in
     celllabel.delegate = self
     celllabel.placeholder = "タイトル変更"
     }
     //日付変える時
     alert.addTextField { (dateLabel) in
     dateLabel.delegate = self
     dateLabel.placeholder = "日付変更"
     }
     let titleButton = UIAlertAction(title: "タイトル確定", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
     // ボタンが押された時のコード
     let getD = TaskManager.getData()
     
     if let textField = alert.textFields?.first{
     self.celllabel.text = textField.text
     }
     getD[self.index].title = self.celllabel.text ?? ""
     
     //getD[self.index]
     TaskManager.saveData(task: getD)
     
     })
     let dateButton = UIAlertAction(title: "日付確定", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
     
     // ボタンが押された時のコード
     let getD = TaskManager.getData()
     
     if let textField = alert.textFields?.first{
     self.dateLabel.text = textField.text
     }
     getD[self.index].date = self.dateLabel.text ?? ""
     
     //getD[self.index]
     TaskManager.saveData(task: getD)
     
     })
     
     let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {(action: UIAlertAction!) -> Void in
     // ボタンが押された時のコード
     
     })
     
     
     
     alert.addAction(titleButton)
     alert.addAction(dateButton)
     alert.addAction(cancelButton)
     
     delegate!.present(alert, animated: true, completion: nil)
     */
}


