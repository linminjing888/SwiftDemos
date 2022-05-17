//
//  CodeableViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/5/17.
//

import Foundation

struct Product: Codable {
    var firstName: String?
    var age: Int
    var description: String?
}

class CodableViewController: MJBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Codeable"
        
        encoderMethod()
        
        decoderMethod()
        
        decoderMethod2()
        
        decoderMethod3()
    }
    
    // 模型转json
    func encoderMethod() {
        
        let product = Product(firstName: "123456", age: 22, description: "ceshi11")
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(product)
            if let codingString = String.init(data: data, encoding: .utf8) {
                print(codingString)
            }
        } catch {
            print("结构体转data失败")
        }
    }
    
    // json转模型
    func decoderMethod() {

        let json = """
            {
                "firstName": "米饭童鞋",
                "age": 200,
                "description": "A handsome boy."
            }
        """

        let decoder = JSONDecoder()
        if let productData = json.data(using: .utf8) {

            if let product = try? decoder.decode(Product.self, from: productData){
                print(product.firstName ?? "");
            }
        }
    }
    
    /// 自定义
    func decoderMethod2() {
        
        let json = """
            {
                "first_name": "hahahahha",
                "age": 25,
                "description": "good morning"
            }
        """
        
        let decoder = JSONDecoder()
        if let productData = json.data(using: .utf8) {
            
            if let product = try? decoder.decode(ProductModel.self, from: productData){
                print(product.firstName ?? "");
            }
        }
    }
    
    /// 数组
    func decoderMethod3() {

        let jsonString = "[{\"firstName\":\"aaaaa\",\"age\":23},{\"firstName\":\"bbbbb\",\"age\":25}]"

        let decoder = JSONDecoder()
        if let productData = jsonString.data(using: .utf8) {

            do {
                let products = try decoder.decode([Product].self, from: productData)
                for product in products {
                    print(product.firstName ?? "")
                }
            } catch {
                print("异常处理")
            }
        }
    }
}
