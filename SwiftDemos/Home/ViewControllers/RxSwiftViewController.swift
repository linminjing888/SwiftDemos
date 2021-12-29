//
//  RxSwiftViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/12/28.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController : MJBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RxSwift"
        self.setupDemo()
    }
    
    func setupDemo() {
        
        let commitBtn = CustomButton(type: .custom)
        commitBtn.backgroundColor = .cyan
        view.addSubview(commitBtn)
        commitBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 50))
        }
        // commitBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        commitBtn.rx.tap.subscribe(onNext:  {
            print("1244")
        })

    }
    
    @objc func btnAction() {
        print("1233")
    }
    
}
