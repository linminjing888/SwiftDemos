//
//  SingleManager.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/8/24.
//

class SingleManager {
    // 单例
    static let shared = SingleManager()
    // 一定要加private防止外部通过init直接创建实例
    private init() {}
    
    var aValue: String?
    var bValue: String?
    
}
