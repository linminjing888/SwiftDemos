//
//  UIColorExtension.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/7.
//

import UIKit

extension UIColor {
    
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    /// 背景色
    class var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    /// 主题色
    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func hex(hexString: String) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.black }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(r: r, g: g, b: b)
    }
    
    
    /// 便利构造函数
    /// - Parameters:
    ///   - lightThemeColor: 明亮主题的颜色
    ///   - darkThemeColor: 黑暗主题的颜色
    public convenience init(lightThemeColor: UIColor, darkThemeColor: UIColor? = nil){
        if #available(iOS 13.0, *) {
            self.init { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return lightThemeColor
                case .unspecified:
                    return lightThemeColor
                case .dark:
                    return darkThemeColor ?? lightThemeColor
                @unknown default:
                    fatalError()
                }
            }
        }else {
            self.init(cgColor: lightThemeColor.cgColor);
        }
    }
    
    static let mainTextColor = UIColor(lightThemeColor: .black, darkThemeColor: .white)
    
    static let mainBgColor = UIColor(lightThemeColor: .white, darkThemeColor: .black);
    
    static let mainTabBgColor = UIColor(lightThemeColor: UIColor(r: 242, g: 242, b: 242), darkThemeColor: .black.withAlphaComponent(0.8))
}
