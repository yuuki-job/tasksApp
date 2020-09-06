//
//  ViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/08/31.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memos:[String] = ["あ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 55
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        let button:UIButton = UIButton(frame: CGRect(x: 300, y: 650, width: 40, height: 40))
        button.backgroundColor = .blue
        button.setTitle("＋", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    @objc func didTapButton() {
        let aptVC = self.storyboard?.instantiateViewController(withIdentifier: "task") as! apendTaskViewController
        self.navigationController?.pushViewController(aptVC, animated: true)
    }

}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomCell
        
        cell?.celllabel.text = memos[indexPath.row]
        cell?.heart.imageView?.image =  UIImage(systemName:"heart")
        return cell!
    }
    
}
