//
//  MessageViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/6.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import MJRefresh
import Kingfisher

class MessageViewController: MJBaseViewController {

    lazy var tableView = UITableView()
    lazy var items = [Item]()
    var page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "消息"
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        header.beginRefreshing()
        tableView.mj_header = header
     
        let footer = MJRefreshBackNormalFooter(refreshingBlock: self.loadMoreData)
        tableView.mj_footer = footer

    }
    
    @objc func loadData() {
        
        AF.request(API.imgrank, method: .get, parameters: ["page": 1]).responseJSON { (response) in

            switch(response.result) {
                case .success(let value):
                    let json = JSON(value).dictionaryObject
                    if let model: Content = Content.deserialize(from: json) {
                        self.items.removeAll()
                        self.items.append(contentsOf: model.items)
                        
                        self.tableView.reloadData()
                        self.tableView.mj_header?.endRefreshing()
                        
                        print(self.items.count)
                    }
                case .failure(let error):
                    print("Error message:\(error)")
            }
        }
    }
    
    @objc func loadMoreData() {
        
        AF.request(API.imgrank, method: .get, parameters: ["page": page + 1]).responseJSON { (response) in

            switch(response.result) {
                case .success(let value):
                    let json = JSON(value).dictionaryObject
                    if let model: Content = Content.deserialize(from: json) {
                        
                        self.items.append(contentsOf: model.items)
                        
                        self.tableView.reloadData()
                        self.tableView.mj_footer?.endRefreshing()
                        
                        print(self.items.count)
                        self.page += 1
                    }
                case .failure(let error):
                    print("Error message:\(error)")
            }
        }
    }
    
}

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        let item = items[indexPath.row]
        
        let url = item.user.thumb.replacingOccurrences(of: ".webp", with: ".jpg")
        cell?.imageView?.kf.setImage(with: URL(string: url))
        cell?.textLabel?.text = item.user.login
        cell?.detailTextLabel?.text = item.content
        return cell!
    }
    
    
}
