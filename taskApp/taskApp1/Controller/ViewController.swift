//
//  ViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/08/31.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Catchprptocol {
    var editBarButtonItem = UIBarButtonItem()
    
    @IBOutlet weak var tableView: UITableView!
    
    var memos:[[String:String]]{
        get{
            var me = [[String:String]]()
            let defaults = UserDefaults.standard
            if let lists = defaults.array(forKey: "memos") as? [[String:String]]{
                me = lists
            }
            return me
        }
        
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "memos")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 55
        //カスタム？セルのやつ？
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //ボタンのコード
        let button:UIButton = UIButton(frame: CGRect(x: 300, y: 650, width: 40, height: 40))
        button.backgroundColor = .blue
        button.setTitle("＋", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        //ナビゲーションのコード
        editBarButtonItem = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editBarButtonTapped(_:)))
        // ③バーボタンアイテムの追加
        navigationItem.leftBarButtonItems = [editBarButtonItem]
        
    }
    //背景が青で、文字が＋の白色の丸いをボタンタップした時の処理
    @objc func didTapButton() {
        let aptVC = self.storyboard?.instantiateViewController(withIdentifier: "task") as! apendTaskViewController
        self.navigationController?.pushViewController(aptVC, animated: true)
    }
    
    // "編集"ボタンが押された時の処理
    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        
        print("【編集】ボタンが押された!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
        
        print(editing)
    }
    
    func catchString() {
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
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

//tableViewのところ
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.delegate = self
        cell.celllabel.text = memos[indexPath.row]["task"]
        cell.heart.imageView?.image =  UIImage(systemName:"heart")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 先にデータを削除しないと、エラーが発生します。
        self.memos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
