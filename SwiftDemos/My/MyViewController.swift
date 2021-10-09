//
//  MyViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/6.
//

import UIKit

class MyViewController: MJBaseViewController {
    
    private lazy var dataArray: Array = {
        return [
            [["icon":"mine_vip", "title": "我的VIP"],
            ["icon":"mine_coin", "title": "充值妖气币"],
            ["icon":"mine_subscript", "title": "我的订阅"]],
                    
            [["icon":"mine_message", "title": "我的消息/优惠券"],
            ["icon":"mine_accout", "title": "消费记录"],
            ["icon":"mine_freed", "title": "在线阅读免流量"]],
                    
            [["icon":"mine_feedBack", "title": "帮助中心"],
             ["icon":"mine_mail", "title": "我要反馈"],
             ["icon":"mine_judge", "title": "给我们评分"],
             ["icon":"mine_author", "title": "成为作者"],
             ["icon":"mine_setting", "title": "设置"]]
        ]
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .mainTabBgColor // UIColor.background
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
       return tableView
    }()
    
    private lazy var header: MyHeaderView = {
        return MyHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
    }()
    
    private lazy var navBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    let cellId = "myCellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.hex(hexString: "f69c9f")
        edgesForExtendedLayout = .top
        MJLog("123")
    }
    
    override func setupLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {(make) in
            make.edges.equalTo(self.view.snp.edges).priority(.low)
            make.top.equalToSuperview()
        }
        
        tableView.parallaxHeader.view = header
        tableView.parallaxHeader.height = 200
        tableView.parallaxHeader.minimumHeight = navBarY
        tableView.parallaxHeader.mode = .fill
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        navigationController!.barStyle(.clear)
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.parallaxHeader.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
    }

}

extension MyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -(scrollView.parallaxHeader.minimumHeight)  {
            if #available(iOS 15.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithTransparentBackground() // 重置背景和阴影颜
                navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                navBarAppearance.backgroundImage = UIImage(named: "nav_bg");
                navBarAppearance.shadowImage = UIImage();
                
                navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                navigationController?.navigationBar.standardAppearance = navBarAppearance
                self.navigationController?.navigationBar.isTranslucent = true;
            }else{
                navigationController?.barStyle(.theme)
            }
            navigationItem.title = "我的"
        }else{
            navigationController!.barStyle(.clear)
            navigationItem.title = ""
        }
    }
    
}

extension MyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionArr = dataArray[section]
        return sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        let sectionArr = dataArray[indexPath.section]
        let dict: [String : String] = sectionArr[indexPath.row]
        cell.imageView?.image = UIImage(named: dict["icon"] ?? "")
        cell.textLabel?.text = dict["title"]
        
        return cell
    }
    
}
