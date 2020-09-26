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
class TaskTableViewCell: UITableViewCell {

    var delegate: UIViewController?
    var flg = false
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var heartButtondisp: UIButton!
    @IBOutlet weak var celllabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {        super.setSelected(selected, animated: animated)
        
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
        
        
        switch flg {
        case false:
            heartButtondisp.setImage(image, for: .normal)
            flg = true
            let heartVC = delegate.self?.storyboard?.instantiateViewController(withIdentifier: "next") as! HearpagetViewController
            
            heartVC.rezmemo = 
                print(true)
        case true:
            heartButtondisp.setImage(whiteImage, for: .normal)
            flg = false
            print(false)
        default:
            print("a")
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
}

