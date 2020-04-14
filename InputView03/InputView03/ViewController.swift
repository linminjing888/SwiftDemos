//
//  ViewController.swift
//  InputView03
//
//  Created by MinJing_Lin on 2020/4/14.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    var inputTextView:UITextView!
    var limitLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
        let navigationHeight = (bottomSafeAreaHeight == 0.0 ? 64.0 :88.0)
        
        setupNavigationBar()
        
        inputTextView = UITextView()
        let width:CGFloat = self.view.frame.width
        inputTextView.frame = CGRect(x: 15.0, y: navigationHeight, width: Double(width), height: 300.0)
        inputTextView.backgroundColor = .lightGray
        inputTextView.delegate = self
        self.view.addSubview(inputTextView);
        
        limitLabel = UILabel()
        limitLabel.text = "20"
        limitLabel.textAlignment = .right
        limitLabel.textColor = UIColor.blue
        limitLabel.frame = CGRect(x:Double(self.view.frame.width) - 60.0, y: 300.0 + navigationHeight - 25, width: 60.0, height: 25.0)
        self.view.addSubview(limitLabel)
    }
    
    func setupNavigationBar() {
        
        let leftItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "send", style: .plain, target: self, action: nil)
        rightItem.tintColor = UIColor.green
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var currentCount = textView.text.count
        if currentCount >= 20 {
            currentCount =  20
            if let str = textView.text {
                // 截取字段
                let startIdx = str.startIndex
                let index = str.index(startIdx, offsetBy: 20)
                textView.text = String(textView.text.prefix(upTo: index))
                
                inputTextView.resignFirstResponder()
            }
        }
        limitLabel.text = "\(20 - currentCount)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            inputTextView.resignFirstResponder()
        }
        return true
    }
}

