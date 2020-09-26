//
//  CustomCell.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/03.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit


class TaskTableViewCell: UITableViewCell {

    var task: [String: Any]!
    var index: Int!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var heartButtondisp: UIButton!
    @IBOutlet weak var celllabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(task: [String: Any], index: Int) {
    
    guard let isFavorite = task["isFavorite"] as? Bool else {
        return
    }

    if isFavorite {
        heartButtondisp.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    } else {
        heartButtondisp.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    celllabel.text = task["task"] as? String
    dateLabel.text = task["date"] as? String
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
        
        guard let isFavorite = task["isFavorite"] as? Bool else {
            return
        }
        
        if isFavorite {
            heartButtondisp.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            heartButtondisp.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        var saveData = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] ?? []
        saveData[index]["isFavorite"] = !isFavorite
        
        UserDefaults.standard.set(saveData, forKey: "tasks")
        //なんで書いてあるのかわからない。
        task["isFavorite"] = !isFavorite
        
        print(saveData)
    }
    
    
        
        
        /*if flg == false{
            heartButtondisp.setImage(image, for: .normal)
         flg = true
         print("true")
         }
         else{
            heartButtondisp.setImage(whiteImage, for: .normal)
         flg = false
         print("false")
        }*/
    }


