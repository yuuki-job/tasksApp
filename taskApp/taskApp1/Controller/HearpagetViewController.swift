//
//  hearpagetViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/08/31.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class HearpagetViewController: UIViewController{
   
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    var rezmemo:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //カスタム？セルのやつ？
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    
}
extension HearpagetViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rezmemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rezmemo[indexPath.row] as? String
        return cell
        
    }
    
    
}
