//
//  ReverseValueViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/8/20.
//

import UIKit

class ReverseValueViewController: MJBaseViewController {

    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "123"
        return lbl
    }()
    lazy var ageLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "456"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "逆向传值";
        
        let rightItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
        
        view.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        view.addSubview(ageLbl)
        ageLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLbl.snp.bottom).offset(20);
            make.height.equalTo(20)
        }
    }
    
    @objc func nextAction() {
        let vc = ReverseValueTwoViewController()
        vc.finishBlock = { [weak self] (value) in
            self?.nameLbl.text = "闭包：\(value)"
        }
        vc.delegate = self
        vc.titleStr = self.nameLbl.text
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ReverseValueViewController: ValueDelegate {
    func ReverseValueFinished(value: String) {
        self.ageLbl.text = "协议：\(value)"
    }
    
}
