//
//  MJNaviViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/8.
//

import UIKit

class MJNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 在自定义导航控制器 或者 自定义返回按键的时候,滑动返回的手势经常会失效. 下面是解决的方法
        self.interactivePopGestureRecognizer?.delegate = self // 1.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        self.interactivePopGestureRecognizer?.isEnabled = true // 3.
    }

}

extension MJNaviViewController: UIGestureRecognizerDelegate,UINavigationControllerDelegate { // 2.
    
}

extension MJNaviViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
}

// 枚举
enum NavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController {
    
//    private struct AssociatedKeys {
//        static var disablePopGesture: Void?
//    }
//    
//    var disablePopGesture: Bool {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
    
    func barStyle(_ style: NavigationBarStyle) {
        
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground() // 重置背景和阴影颜

            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.backgroundColor = UIColor.clear
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            switch style {
                case .theme:
                    navigationBar.barStyle = .black
                    navBarAppearance.backgroundImage = UIImage(named: "nav_bg");
                    navBarAppearance.shadowImage = UIImage();
                self.navigationBar.isTranslucent = false;
                case .clear:
                    navigationBar.barStyle = .black
                    navBarAppearance.backgroundImage = UIColor.clear.image();
                    navBarAppearance.shadowImage = UIColor.clear.image();
                    self.navigationBar.isTranslucent = true;
                case .white:
                    navigationBar.barStyle = .default
                    navBarAppearance.backgroundImage = UIColor.white.image();
                    navBarAppearance.shadowImage = UIImage();
                    self.navigationBar.isTranslucent = false;
            }
            
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationBar.standardAppearance = navBarAppearance

        }else{
            switch style {
                case .theme:
                    navigationBar.barStyle = .black
                    navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
                    navigationBar.shadowImage = UIImage()
                case .clear:
                    navigationBar.barStyle = .black
                    navigationBar.setBackgroundImage(UIImage(), for: .default)
                    navigationBar.shadowImage = UIImage()
                case .white:
                    navigationBar.barStyle = .default
                    navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
                    navigationBar.shadowImage = nil
            }
        }

    }

}
