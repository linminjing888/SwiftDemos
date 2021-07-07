//
//  TabbarViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/6.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(Tabbar(), forKeyPath: "tabBar") // KVO
        
        tabBar.barTintColor = UIColor.white
        
        addChild("首页", "tabbar_home", HomeViewController.self)
        addChild("消息", "tabbar_message_center", MessageViewController.self)
        addChild("我的", "tabbar_profile", MyViewController.self)

    }
    
    func addChild(_ title: String,
                  _ imageName: String,
                  _ type : UIViewController.Type) {
    
        let homeNav = UINavigationController(rootViewController: type.init())
        homeNav.title = title
        homeNav.tabBarItem.image = UIImage(named: imageName)
        homeNav.tabBarItem.selectedImage = UIImage(named: (imageName + "_selected"))?.withRenderingMode(.alwaysOriginal)
        homeNav.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.orange
        ], for: .selected)
        addChild(homeNav)
    }
    

}
