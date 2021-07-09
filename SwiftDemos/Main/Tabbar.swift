//
//  Tabbar.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/6.
//

import UIKit

class Tabbar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in subviews where button is UIControl{
//            print(button)
            var frame = button.frame
            frame.origin.y = -2
            button.frame = frame
            
        }
    }

}
