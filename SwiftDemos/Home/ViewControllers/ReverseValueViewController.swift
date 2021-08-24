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
    lazy var sexLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "789"
        return lbl
    }()
    lazy var cityLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "222"
        return lbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let aa = SingleManager.shared.aValue else { return }
        sexLbl.text = "单例：\(aa)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "逆向传值";
        
        let rightItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
        
        view.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.height.equalTo(20)
        }
        view.addSubview(ageLbl)
        ageLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLbl.snp.bottom).offset(20);
            make.height.equalTo(20)
        }
        view.addSubview(sexLbl)
        sexLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageLbl.snp.bottom).offset(20);
            make.height.equalTo(20)
        }
        view.addSubview(cityLbl)
        cityLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sexLbl.snp.bottom).offset(20);
            make.height.equalTo(20)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifiAction), name: NSNotification.Name(rawValue: "textChangeKey"), object: nil)
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
    
    @objc func notifiAction(notifi: Notification) {
        let str = notifi.userInfo!["text"]
        self.cityLbl.text = "通知：\(str ?? "")"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ReverseValueViewController: ValueDelegate {
    func ReverseValueFinished(value: String) {
        self.ageLbl.text = "协议：\(value)"
    }
    
}
