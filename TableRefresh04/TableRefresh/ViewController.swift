//
//  ViewController.swift
//  TableRefresh
//
//  Created by MinJing_Lin on 2020/4/15.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    var dataArr = Array<String>()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addData()
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        refresh.attributedTitle = NSAttributedString(string: "别拉了，再拉就下来了")
        refresh.addTarget(self, action: #selector(refreshMethod), for: .valueChanged)
        tableView.addSubview(refresh)
        
    }

    
    @objc func refreshMethod()  {
        addData()
        refresh.endRefreshing()
        tableView.reloadData()
    }
    
    func addData() {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日/HH时mm分ss秒"
        let dateStr = dateFormatter.string(from: date as Date)
        dataArr.append(dateStr)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }

}

