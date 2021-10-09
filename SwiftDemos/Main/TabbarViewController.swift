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
        
        if #available(iOS 15, *) {
             let appearance = UITabBarAppearance()
             appearance.configureWithOpaqueBackground()
             appearance.backgroundColor = .mainBgColor
             UITabBar.appearance().standardAppearance = appearance
             UITabBar.appearance().scrollEdgeAppearance = appearance
             UITabBar.appearance().tintColor = UIColor.orange
        }else{
            tabBar.barTintColor = UIColor.white
            tabBar.isTranslucent = false
        }
        
        addChild("首页", "tabbar_home", HomeViewController.self)
        addChild("消息", "tabbar_message_center", MessageViewController.self)
        addChild("我的", "tabbar_profile", MyViewController.self)

    }
    
    func addChild(_ title: String,
                  _ imageName: String,
                  _ type : UIViewController.Type) {
    
        let homeNav = MJNaviViewController(rootViewController: type.init())
        homeNav.barStyle(.theme)
        homeNav.title = title
        homeNav.tabBarItem.image = UIImage(named: imageName)
        homeNav.tabBarItem.selectedImage = UIImage(named: (imageName + "_selected"))?.withRenderingMode(.alwaysOriginal)
        homeNav.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.orange
        ], for: .selected)
        addChild(homeNav)
    }
    
}

extension TabbarViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
