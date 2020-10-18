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
    
    var  editSystem = true
    
    var datepickerView = UIDatePicker()
    
    var textField = UITextField()
    
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
}
extension TaskListViewController:TaskTableViewCellDelegate{
    
    //デリゲートメソッド
    func alertDisplay(title: String, date: String,indexEdit:Int) {
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle:  .alert)
        
        let getTask = TaskManager.getData()
        //タイトルのテキストを作っている
        alert.addTextField { (textField) in
            //celllabel.delegate = self
            //textField.textはテキストに表示されるテキスト
            textField.text = title
            textField.placeholder = "タイトル変更"
        }
        //日付のテキストを作っている
        alert.addTextField { (textField) in
            // ピッカー設定
            //ドキュメントとなんか違う
            self.datepickerView.datePickerMode = UIDatePicker.Mode.date
            self.datepickerView.timeZone = NSTimeZone.local
            self.datepickerView.locale = Locale.current
            
            // 決定バーの生成
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 35))
            let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            //doneは前のviewに戻る？
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
            //setItemsの中身はツールバーに表示する項目
            toolbar.setItems([spacelItem, doneItem], animated: true)
            // インプットビュー設定
            textField.inputView = self.datepickerView
            textField.inputAccessoryView = toolbar
            
            self.textField = textField
            textField.text = date
            textField.placeholder = "日付変更"
        }
        // 確定ボタンが押された場合のコード
        let confirmButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) -> Void in
            
            //let useCellLabel = TaskTableViewCell()
            guard let title = alert.textFields?[0].text,let date = alert.textFields?[1].text else {
                return
            }
            getTask[indexEdit].title = title
            getTask[indexEdit].date = date
            TaskManager.saveData(task: getTask)
            self.tasks = getTask
            self.tableView.reloadData()
            
        })
        
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {(action: UIAlertAction!) -> Void in
            // ボタンが押された時のコード
            
        })
        //tasks = TaskManager.getData()
        
        alert.addAction(confirmButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    // 決定ボタン押下
    @objc func done() {
        textField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        //日本語に変えている
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd"
        //dateは日付ピッカーによって表示される日付。また、ピッカーが作成された現在の日付
        textField.text = (formatter.string(from: datepickerView.date))
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
