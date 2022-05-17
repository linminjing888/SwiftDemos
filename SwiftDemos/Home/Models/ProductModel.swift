//
//  ProductModel.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/5/17.
//

import Foundation

struct ProductModel: Codable {
    var firstName: String?
    var age: Int
    var description: String?
    
    /// 自定义字段属性
    /// 注意
    /// 1.需要遵守Codingkey
    /// 2.每个字段都要枚举 否则会得到一个 Type 'ProductModel' does not conform to protocol 'Codable' 的编译错误
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case age
        case description
    }
}
