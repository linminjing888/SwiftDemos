//
//  MJTextInputViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import UIKit

class TextInputViewController: MJBaseViewController {

    var inputTextView: UITextView!
    var limitLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        setupUI()
    }
    
    func setupNavigationBar() {
//        let leftItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: nil)
//        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "send", style: .plain, target: self, action: nil)
        rightItem.tintColor = UIColor.orange
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func setupUI() {
        
        inputTextView = UITextView()
        inputTextView.frame = CGRect(x: 20, y: nav_bar_h + 20, width: SCREEN_WIDTH - 40, height: 300)
        inputTextView.backgroundColor = .lightGray
        inputTextView.delegate = self
        inputTextView.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(inputTextView)
        
        limitLbl = UILabel()
        limitLbl.text = "20"
        limitLbl.textAlignment = .right
        limitLbl.textColor = .blue
        limitLbl.frame = CGRect(x: SCREEN_WIDTH-80, y: nav_bar_h + 40 + 300, width: 60, height: 25)
        self.view.addSubview(limitLbl)
        
    }


}

extension TextInputViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        var currentCount = textView.text.count
        if currentCount >= 20 {
            currentCount = 20
            
            if let str = textView.text {
                textView.text = String(str.prefix(20))
                inputTextView.resignFirstResponder()
            }
        }
        limitLbl.text = "\(currentCount) / 20"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            inputTextView.resignFirstResponder()
        }
        return true
    }
}


/**
 // 头部截取
 let str = "asdfghjkl;'"
 let str1 = str.prefix(2);
 print(str1)
 // 结果: as
   
 // 尾部截取
 let str2 = str.suffix(3);
 print(str2)
 // 结果: l;'

 // range 截取
 let index3 = str.index(str.startIndex, offsetBy: 3)
 let index4 = str.index(str.startIndex, offsetBy: 5)
 let str5 = str[index3...index4]
 print(str5)
 // 结果:fgh
 */
