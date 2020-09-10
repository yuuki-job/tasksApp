//
//  apendTaskViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/06.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class apendTaskViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var datepickerView = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ピッカー設定
        //ドキュメントとなんか違う
        datepickerView.datePickerMode = UIDatePicker.Mode.date
        datepickerView.timeZone = NSTimeZone.local
        datepickerView.locale = Locale.current
        dateTextField.inputView = datepickerView
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        dateTextField.inputView = datepickerView
        dateTextField.inputAccessoryView = toolbar
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    // 決定ボタン押下
    @objc func done() {
        dateTextField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        //日本語に変えている
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd"
        //dateは日付ピッカーによって表示される日付。
        dateTextField.text = "\(formatter.string(from: datepickerView.date))"
    }
    @IBAction func taskApendButton(_ sender: Any) {
        
        guard let taskText = taskTextField.text,let dateText = dateTextField.text else {
            
            return
        }
        //前の保存してあるものが入れ変わらないように、前のデータを一回保存する。
        var saveData = UserDefaults.standard.array(forKey: "memos") as? [[String:String]] ?? []
        let memos = ["task":taskText,"date":dateText]
        saveData.append(memos)
        
        UserDefaults.standard.set(saveData, forKey: "memos")
        
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
}
