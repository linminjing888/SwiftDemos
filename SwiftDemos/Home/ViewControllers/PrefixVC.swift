//
//  PrefixVC.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/7/26.
//

import Foundation
import UIKit

class PrefixVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "前缀"
        self.view.backgroundColor = .white
        
        let str1 = "ee456667gfd"
        print(str1.mj.numsCount)

        print(String.mj.test())

        let p = Person("xiaoming")
        print(p.mj.run())
        
        let logo = LogoImageView(radius: 8)
        logo.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        logo.image = UIImage(named: "icon")
        view.addSubview(logo)
        
    }
}

// Swift风格为属性/函数添加前缀(方式3)
// 1. 前缀类型（中介）
struct MJ<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}
// 2. 利用协议扩展前缀属性
protocol MJCompatible { }

extension MJCompatible {
    
    var mj: MJ<Self> {
        set{}
        get{ MJ(self)}
    }
    static var mj: MJ<Self>.Type {
        set{}
        get{MJ<Self>.self}
    }
}
// 3. 让String拥有db前缀属性
extension String: MJCompatible{}
// 4. 给db前缀（实例/类型）扩展功能
extension MJ where Base == String {
    
    var numsCount: Int {
        var count = 0
        for s in base where ("0"..."9").contains(s) {
            count += 1
        }
        return count
    }
    
    static func test() {
        print("string test")
    }
}
// 为自定义类扩展方法
class Person {
    var name: String
    init(_ name: String) {
        self.name = name
    }
}

extension Person: MJCompatible{}

extension MJ where Base: Person {
    
    func run() {
        print(base.name + "running")
    }
}


/**
// Swift风格为属性/函数添加前缀(方式2)
struct MJ<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

extension String {
    var mj: MJ<String> {
        return MJ(self)
    }
    // 扩展类方法/属性
    static var mj: MJ<String>.Type {
        return MJ<String>.self
    }
}

extension MJ where Base == String {
    
    var numsCount: Int {
        var count = 0
        for s in base where ("0"..."9").contains(s) {
            count += 1
        }
        return count
    }
    
    static func test() {
        print("string test")
    }
}

class Person {
    var name: String
    init(_ name: String) {
        self.name = name
    }
}

extension Person {
    var mj: MJ<Person> {
        return MJ(self)
    }
}

extension MJ where Base: Person {
    
    func run() {
        print(base.name + "running")
    }
}
*/

/**
// Swift风格为属性/函数添加前缀(方式1)
struct MJ {
    var string: String
    init(_ string: String) {
        self.string = string
    }
    
    var numsCount: Int {
        var count = 0
        for s in string where ("0"..."9").contains(s) {
            count += 1
        }
        return count
    }
}

extension String {
    var mj: MJ {
        return MJ(self)
    }
}
 */

// MARK: - 面向协议编程

/// 声明一个圆角的能力协议
protocol RoundCornerable {
    func roundCorner(radius: CGFloat)
}

/// 通过扩展给这个协议方法添加默认实现，必须满足遵守这个协议的类是继承UIView的。
extension RoundCornerable where Self: UIView {
    func roundCorner(radius: CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

/// 声明抖动动画的协议
protocol Shakeable {
    func startShake()
}

/// 实现协议方法内容，并指定只有LogoImageView才可以使用。
extension Shakeable where Self: LogoImageView {
    
    func startShake() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform"
        animation.duration = 0.25
        
        let origin = CATransform3DIdentity
        let minimum = CATransform3DMakeScale(0.8, 0.8, 1)
        
        let originValue = NSValue(caTransform3D: origin)
        let minimumValue = NSValue(caTransform3D:minimum)
        
        animation.values = [originValue, minimumValue, origin, minimumValue, origin]
        layer.add(animation, forKey: "bounce")
        layer.transform = origin
    }
}

class LogoImageView: UIImageView, RoundCornerable, Shakeable {
    init(radius: CGFloat = 5) {
        super.init(frame: CGRect.zero)
        
        roundCorner(radius: radius)
        
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(shakeEvent))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func shakeEvent() {
        startShake()
    }
}
