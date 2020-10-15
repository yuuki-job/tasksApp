//
//  ViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/08/31.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController{
    
    var tasks:[Task] = []
    
    var editBarButtonItem = UIBarButtonItem()
    
    var  editSystem = true
    
    var delegate:TaskTableViewCellDelegate?
    
    var receiveTitle = ""
    var receiveIndex = ""
    
    var datepickerView = UIDatePicker()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        createButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tasks = Task.saveTasks
        tasks = TaskManager.getData()
      
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        //カスタム？セルのやつ？
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    private func createButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 300, y: 650, width: 40, height: 40))
        button.backgroundColor = .blue
        button.setTitle("＋", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.view.addSubview(button)
    }
    //背景が青で、文字が＋の白色の丸いをボタンタップした時の処理
    @objc func didTapButton() {
        let aptVC = self.storyboard?.instantiateViewController(withIdentifier: "task") as! ApendTaskViewController
        self.navigationController?.pushViewController(aptVC, animated: true)
    }
    //編集ボタン押した時
    @IBAction func deleteButton(_ sender: Any) {
        
        if editSystem == true{
            tableView.setEditing(true, animated: true)
            editSystem = false
        } else {
            tableView.setEditing(false, animated: true)
            editSystem = true
        }
    }
    /*override func setEditing(_ editing: Bool, animated: Bool) {
     super.setEditing(editing, animated: animated)
     tableView.isEditing = editing
     print(editing)
     }*/
}
extension TaskListViewController:TaskTableViewCellDelegate{
    
    //デリゲート
    func alertDisplay() {
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle:  .alert)
        //タイトル変える時
        alert.addTextField { (textField:UITextField) in
            //celllabel.delegate = self
            var getDT = TaskManager.getData()
            
            textField.text = self.receiveTitle
            textField.tag = 1
            textField.placeholder = "タイトル変更"
        }
        //日付変える時
        alert.addTextField { (textField) in
            //dateLabel.delegate = self
            
            textField.tag = 2
            textField.placeholder = "日付変更"
        }
        let titleButton = UIAlertAction(title: "タイトル確定", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
            // ボタンが押された時のコード
            let getD = TaskManager.getData()
            let useCellLabel = TaskTableViewCell()
            
            guard let textFields = alert.textFields else {
                return
            }
            for text in textFields {
                if text.tag == 1 {
                    useCellLabel.celllabel.text = text.text
                    
                } else {
                    useCellLabel.dateLabel.text = text.text
                }
            }
            TaskManager.saveData(task: getD)
            
        })
        let dateButton = UIAlertAction(title: "日付確定", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
            
            // ボタンが押された時のコード
            let getD = TaskManager.getData()
            
            
            if let textField = alert.textFields?.first{
                //self.dateLabel.text = textField.text
            }
            //getD[self.index]
            TaskManager.saveData(task: getD)
            
        })
        
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {(action: UIAlertAction!) -> Void in
            // ボタンが押された時のコード
            
        })
        
        alert.addAction(titleButton)
        alert.addAction(dateButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    func greatpicer() {
        
        // ピッカー設定
        //ドキュメントとなんか違う
        datepickerView.datePickerMode = UIDatePicker.Mode.date
        datepickerView.timeZone = NSTimeZone.local
        datepickerView.locale = Locale.current
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
            
            
            
            // インプットビュー設定
            
        // .inputView = datepickerView
        // dateTextField.inputAccessoryView = toolbar
    }
    // 決定ボタン押下
    @objc func done() {
        // dateTextField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        //日本語に変えている
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd"
        //dateは日付ピッカーによって表示される日付。また、ピッカーが作成された現在の日付
        //dateTextField.text = (formatter.string(from: datepickerView.date))
    }
}
//tableViewのところ
extension TaskListViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskTableViewCell
        cell.setup(task: tasks, index: indexPath.row)
        
        cell.delegate = self
        // cell.flg = memos[indexPath.row]["favorite"] as? Bool
        
        return cell
    }
    
    //セルの削除許可を設定
    func tableView(_ tableView: UITableView,canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    //セルの削除ボタンが押された時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tasks.remove(at: indexPath.row)
            /*tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)*/
            TaskManager.saveData(task: tasks)
            tableView.reloadData()
        }
    }
    //並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        TaskManager.saveData(task: tasks)
    }
    
}
