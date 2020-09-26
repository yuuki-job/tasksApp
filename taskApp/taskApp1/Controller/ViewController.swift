//
//  ViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/08/31.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var editBarButtonItem = UIBarButtonItem()
    
    @IBOutlet weak var tableView: UITableView!
    
    var memos:[[String:Any]]{
        get{
        
            return  UserDefaults.standard.array(forKey: "tasks") as? [[String:Any]] ?? []
        }
        
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "tasks")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupTableView()
       createButton()
        
        //ナビゲーションのコード
        editBarButtonItem = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editBarButtonTapped(_:)))
        // ③バーボタンアイテムの追加
        navigationItem.leftBarButtonItems = [editBarButtonItem]
        
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
}
//tableViewのところ
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskTableViewCell
        cell.setup(task: memos[indexPath.row], index: indexPath.row)
        
        
       // cell.flg = memos[indexPath.row]["favorite"] as? Bool
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 先にデータを削除しないと、エラーが発生します。
        self.memos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
