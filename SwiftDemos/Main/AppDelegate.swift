//
//  AppDelegate.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    var backgroundView: UIView!
//    var maskView: UIView!
    var animationView: UIView!
    
    // 申明手机屏幕旋转方向
    var orientation: UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
        
        
//        backgroundView = UIView(frame: self.window!.frame)
//        backgroundView.backgroundColor = UIColor(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0, alpha: 1)
//        self.window!.addSubview(backgroundView)
//
//        animationView = UIView(frame: backgroundView.frame)
//        animationView.backgroundColor = UIColor.white
//        backgroundView.addSubview(animationView)
//
//        let logoLayer = CALayer()
//        logoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        logoLayer.position = backgroundView.center
//        logoLayer.contents = UIImage(named: "logo")?.cgImage
//        animationView.layer.mask = logoLayer
//
//        let logoAnimation = CAKeyframeAnimation(keyPath: "bounds")
//        logoAnimation.beginTime = CACurrentMediaTime()
//        logoAnimation.duration = 1
//        logoAnimation.keyTimes = [0, 0.4, 1]
//        logoAnimation.delegate = self
//        logoAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 85, height: 85)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 4000, height: 4000))]
//        logoAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
//        logoAnimation.fillMode = CAMediaTimingFillMode.forwards
//        logoLayer.add(logoAnimation, forKey: "zoomAnimation")
        

//        let logoOpacityAnimation = CABasicAnimation(keyPath: "opacity")
//        logoOpacityAnimation.beginTime = CACurrentMediaTime() + 0.5
//        logoOpacityAnimation.duration = 1
//        logoOpacityAnimation.fromValue = 1
//        logoOpacityAnimation.toValue = 0
//        logoOpacityAnimation.delegate = self
//        animationView.layer.add(logoOpacityAnimation, forKey: "opacityAnimation")
        
        let userDefaults = UserDefaults(suiteName: "group.ydq.widget.test")
        userDefaults?.set("123456", forKey: "widget")
        userDefaults?.synchronize()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
}

extension AppDelegate : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

        animationView.layer.mask = nil
        animationView.removeFromSuperview()
        backgroundView.removeFromSuperview()

    }
}

extension UIApplication {
    class func changeOrientationTo(landscapeRight: Bool) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if landscapeRight == true {
            delegate.orientation = .landscapeRight
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }else {
            delegate.orientation = .portrait
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}

extension AppDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.description == "widget.image.url" {
            print("点击了图片")
        }else if url.description == "widget.url" {
            print("---小组件点进来的")
        }
        return true
    }
}
