//
//  CustomCell.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/03.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

protocol Catchprptocol{
    func catchString()
}
class CustomCell: UITableViewCell {

    var delegate: UIViewController?
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var celllabel: UILabel!
    
    
    @IBOutlet weak var heart: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
        
        delegate!.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func heartButton(_ sender: Any) {
        let whiteImage = UIImage(named: "heart")
        
        let image = UIImage(named: "heart.fill")
        
        heart.setImage(image, for: .normal)
        
        //
        
        /*if flg {
         heart.setImage(whiteImage, for: UIControl.State())
         flg = false
         print("false")
         }
         else{
         heart.setImage(image, for: UIControl.State())
         flg = true
         print("true")
         }*/
    }
}

