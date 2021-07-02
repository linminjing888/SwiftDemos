//
//  MJMacro.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import Foundation
import WebKit

// 屏幕宽度
let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.width
// 屏幕高度
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.height


func isiPhoneXScreen() -> Bool {
   guard #available(iOS 11.0, *) else {
       return false
   }
   
   let isX = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
   print("是不是刘海屏呢--->\(isX)")
   return isX
}

let status_bar_h:CGFloat = isiPhoneXScreen() ? 44 : 20;
let nav_bar_h:CGFloat = isiPhoneXScreen() ? 88 : 64;

let tab_bar_h:CGFloat = isiPhoneXScreen() ? (49 + 34) : 49
