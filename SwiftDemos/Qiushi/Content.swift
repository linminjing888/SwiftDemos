//
//  User.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/7.
//

import Foundation
import HandyJSON

struct Content: HandyJSON {
    
    let count: Int = 0
    let items: Array<Item> = []
    var total: Int = 0
    let page: Int = 0
    let refresh: Int = 0
}

