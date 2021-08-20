//
//  StretchyViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/5.
//

import UIKit

class StretchyViewController: MJBaseViewController {

    var tableView: UITableView!
    var bannerImgVi: UIImageView!
    
    let cellH: CGFloat = 60
    let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile"
    var dataArray: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // map 简单说就是数组中每个元素通过某个方法进行转换，最后返回一个新的数组。
//        self.dataArray = lyric.split(separator: ",").map(String.init)
        self.dataArray = lyric.split(separator: ",").map({ a in
            return a + "--"
        })
        
        // flatMap 方法同 map 方法比较类似，只不过它返回后的数组中不存在 nil（自动把 nil 给剔除掉）
        // 还能把数组中存有数组的数组（二维数组、N维数组）一同打开变成一个新的数组。
        self.setupUI()

    }
    
    func setupUI() {
        let bannerH = self.view.frame.width * 1068 / 1600
        
        tableView = UITableView(frame: CGRect(x: 0, y: bannerH + 10, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - nav_bar_h - bannerH - 10))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()

        bannerImgVi = UIImageView(image: UIImage(named: "banner"))
        bannerImgVi.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: bannerH)
        self.view.addSubview(bannerImgVi)
        
    }

}


extension StretchyViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellH
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "stretchyId"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let maxOffsetY = tableView.frame.height
        let validateOffsetY = -offsetY / maxOffsetY
        var scale = 1 + validateOffsetY
        if scale < 1 {
            scale = 1
        }
        bannerImgVi.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        
        
        
    }
    
    
}
