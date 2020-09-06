//
//  CustomCell.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/03.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var celllabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var heart: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func apeendTask(_ sender: Any) {
        
        /*let alert: UIAlertController = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle:  UIAlertController.Style.alert)
         
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
         
        self.present(alert, animated: true, completion: nil)*/
    }
    
    @IBAction func heartButton(_ sender: Any) {
        
        heart.imageView?.image = UIImage(systemName:"heart.fill")
    }
}
