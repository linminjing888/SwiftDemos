//
//  ClosureLearnViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/12/23.
//
// https://www.jianshu.com/p/c9b96c99f2e64

import UIKit

class ClosureLearnViewController: MJBaseViewController {
    
    var callBack: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Closure"
        
        // 闭包表达式
        /**
         {
           (参数列表) -> 返回值类型 in 函数体代码
         }
         */
        print("--闭包表达式")
        let fn = {(v1: Int, v2: Int) -> Int in
            return v1 + v2
        }
        print(fn(10,20))
        
        // 尾随闭包
        print("--尾随闭包")
        func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
            print((fn(v1, v2)));
        }
        
        let result = exec(v1: 1, v2: 2) { a, b in
            return a * b
        }
        let result2 = exec(v1: 1, v2: 2) {
            return $0 * $1
        }
        
        // 逃逸闭包 如果一个闭包被作为一个函数的参数，并且在函数执行完之后才被执行 (一般在涉及到异步操作时)
        print("--逃逸闭包")
        func execc(fnn: @escaping (_ str: String)->() ) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                fnn("aaa")
            }
            print("函数执行完毕")
        }
        execc { str in
            print("闭包执行完毕" + str)
        }
        
        // 自动闭包
        print("--自动闭包")
        func getFirstPositive(_ v1: Int, _ v2: Int) -> Int {
            return v1 > 0 ? v1 : v2;
        }
        print(getFirstPositive(2, 10));
        
        // 改变v2的类型，让v2延迟加载
        func getFirstPositive2(_ v1: Int, _ v2: ()->Int ) -> Int {
            return v1 > 0 ? v1 : v2()
        }
        print( getFirstPositive2(-2) { 10 } )
        
        // @autoclosure 会自动把10封装成闭包 {10}
        // 只支持 () -> T 格式的参数
        // 空合运算符 ?? 使用了 @autoclosure
        func getFirstPositive3(_ v1: Int, _ v2: @autoclosure ()-> Int ) -> Int {
            return v1 > 0 ? v1 : v2()
        }
        // 需要注意的是闭包会有推迟执行的特点，会在函数内部调用时才会执行
        func firstExec()-> Int {
            print("执行了firstExec")
            return 11
        }
        print( getFirstPositive3(-3, firstExec()))
        
        // 闭包 闭包是一个捕获了上下文常量或者变量的函数
        print("--闭包")
        // typealias 是Swift中用来为已经存在的类型重新定义名字的关键字（类似于OC语法中的 typedef）
        typealias Fn = (Int) -> Int
        
        func getFn() -> Fn {
            var num = 0;
            func plus(_ i: Int) -> Int {
                num += i
                return num
            }
            return plus
        }
        
        let fn1 = getFn()
        print(fn1(1))
        print(fn1(2))
        /**
         从三次调用fn1来看，闭包里num都是保存了上次调用后num的值，这是因为闭包捕获了外部的num，并重新在堆上分配了内存，当执行let fn1 = getFn()时，把闭包的内存地址给了fn1， 所以每次调用fn1都是调用的同一块内存，同一个闭包，闭包里有保存中捕获后的num的内存地址，所以每次调用都是同一个num
         */
        
        
        /**
         自动捕获的参数可以修改，并且影响外部变量
         手动捕获的参数本质是值类型，不可修改，跟外部变量没关系了
         */
        print("--自动捕获")
        var age = 10
        let closure = {
           age += 1
        }
        closure()
        print(age)

        print("--手动捕获")
        var num = 10
        let closure2 = { [num] in
           print("闭包内:\(num)")
        }
        num = 11
        closure2()
        print("闭包外:\(num)")
        
        print("循环引用")
//        weak var weakSelf = self
//        printString { text in
//            print(text)
//            weakSelf?.view.backgroundColor = .red
//        }
        
        printString {[weak self] text in
            print(text)
            self?.view.backgroundColor = .red
        }
        
    }
    
    func printString(callBack: @escaping (String) -> ()) {
        callBack("闭包文字")
        self.callBack = callBack
    }
    
    deinit {
        print("---释放了") // 如果循环强引用，就不会释放
    }
}
