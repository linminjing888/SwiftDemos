//
//  ViewController.swift
//  StretchyHeader06
//
//  Created by MinJing_Lin on 2020/5/27.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    let cellHeight:CGFloat = 66
    
    let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile"
    var dataArr:Array<String>!
    
    var tableview: UITableView!
    var bannerImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerH = self.view.frame.width * 1068 / 1600
        
        
        tableview = UITableView()
        tableview.frame = CGRect(x: 0, y: bannerH + 10, width: self.view.frame.width, height: self.view.frame.height - 10 - bannerH)
        self.view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        
        
        bannerImgView = UIImageView(image: UIImage(named: "banner"))
        bannerImgView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: bannerH)
        self.view.addSubview(bannerImgView)
        
//        self.dataArr = lyric.split(separator: ",").map(String.init)
        // map 简单说就是数组中每个元素通过某个方法进行转换，最后返回一个新的数组。
        self.dataArr = lyric.split(separator: ",").map({ $0 + "--" })
        
//        self.dataArr = lyric.split(separator: ",").map({ abc in
//            return abc + "--"
//        })
        
        // flatMap 方法同 map 方法比较类似，只不过它返回后的数组中不存在 nil（自动把 nil 给剔除掉）
        // 还能把数组中存有数组的数组（二维数组、N维数组）一同打开变成一个新的数组。
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = self.dataArr[indexPath.row]
        cell.frame.origin.y = self.cellHeight
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let maxOffsetY = tableview.frame.height
        let validateOffsetY = -offsetY / maxOffsetY
        var scale = 1 + validateOffsetY
        if scale < 1 {
            scale = 1
        }
        bannerImgView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

}

