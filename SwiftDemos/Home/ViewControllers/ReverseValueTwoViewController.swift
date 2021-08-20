//
//  ReverseValueTwoViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/8/20.
//

import UIKit

typealias SwiftBlock = (String) -> Void

class ReverseValueTwoViewController: MJBaseViewController {

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.hex(hexString:"c5c5c5")
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.theme
        btn.layer.cornerRadius = 6.0
        btn.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
        return btn
    }()
    
    var finishBlock: SwiftBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100);
            make.size.equalTo(CGSize(width: 240, height: 50))
            make.centerX.equalToSuperview()
        }

        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 150, height: 50))
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc fileprivate func finishAction() {
        
        let text = textField.text ?? ""
        print(text)
        finishBlock?(text)
        navigationController?.popViewController(animated: true)
    }

}

extension ReverseValueTwoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
