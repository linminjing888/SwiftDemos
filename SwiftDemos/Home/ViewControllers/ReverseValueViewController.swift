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
    }
    
    @objc func nextAction() {
        let vc = ReverseValueTwoViewController()
        vc.finishBlock = { [weak self] (value) in
            self?.nameLbl.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
