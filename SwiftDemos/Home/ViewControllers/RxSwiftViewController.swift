//
//  RxSwiftViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/12/28.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 3
private let minimalPasswordLength = 6

class RxSwiftViewController : MJBaseViewController {
    
//    var ntfObserver: NSObjectProtocol!
    let disposeBag = DisposeBag() // 垃圾袋
    
    private var usernameOutlet: UITextField!
    private var usernameValidOutlet: UILabel!

    private var passwordOutlet: UITextField!
    private var passwordValidOutlet: UILabel!

    private var doSomethingOutlet: UIButton!
    
    private var viewModel: RxSimpleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RxSwift"
        
        // 1.通知
//        ntfObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { noti in
//            print("Application Will Enter Foreground")
//        }
        
//        // 你不需要去管理观察者的生命周期，这样你就有更多精力去关注业务逻辑。
//        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification, object: nil).subscribe { notifi in
//            print("Application Will Enter Foreground")
//        }.disposed(by: disposeBag)
        
        // 2.按钮
//        let commitBtn = CustomButton(type: .custom)
//        commitBtn.backgroundColor = .cyan
//        view.addSubview(commitBtn)
//        commitBtn.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize(width: 80, height: 50))
//        }
//        // commitBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
//        commitBtn.rx.tap.subscribe(onNext:  {
//            print("1244")
//        }).disposed(by: disposeBag)
        
        self.setupUI()
        
        // 3. 输入验证 Rx
//        self.setupDemo()
        
        // 4. 输入验证 MVVM
        self.setupMvvm()
        
    }
    
    func setupUI() {
        
        usernameOutlet = UITextField()
        usernameOutlet.borderStyle = .roundedRect
        view.addSubview(usernameOutlet)
        usernameOutlet.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 45))
        }
        
        usernameValidOutlet = UILabel()
        usernameValidOutlet.text = "用户名至少\(minimalUsernameLength)个字符"
        usernameValidOutlet.textColor = .red
        view.addSubview(usernameValidOutlet)
        usernameValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameOutlet.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 20))
        }
        
        passwordOutlet = UITextField()
        passwordOutlet.borderStyle = .roundedRect
        view.addSubview(passwordOutlet)
        passwordOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameOutlet.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 45))
        }
        
        passwordValidOutlet = UILabel()
        passwordValidOutlet.text = "密码至少\(minimalPasswordLength)个字符"
        passwordValidOutlet.textColor = .red
        view.addSubview(passwordValidOutlet)
        passwordValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 20))
        }
        
        doSomethingOutlet = CustomButton(type: .custom)
        doSomethingOutlet.backgroundColor = .cyan
        doSomethingOutlet.layer.cornerRadius = 6
        doSomethingOutlet.setTitle("登录", for: .normal)
        view.addSubview(doSomethingOutlet)
        doSomethingOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 220, height: 45))
        }
//        doSomethingOutlet.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        doSomethingOutlet.rx.tap.subscribe(onNext:  { [weak self] in
            self?.showAlert()
        }).disposed(by: disposeBag)
        
    }
    
    func setupDemo() {
        
        let userNameValid = usernameOutlet.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .share(replay: 1)
        userNameValid.bind(to: usernameValidOutlet.rx.isHidden).disposed(by: disposeBag)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        passwordValid.bind(to: passwordValidOutlet.rx.isHidden).disposed(by: disposeBag)
        
        let everythingValid = Observable.combineLatest(userNameValid, passwordValid){$0 && $1}.share(replay: 1)
        everythingValid.bind(to: doSomethingOutlet.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func setupMvvm() {
        
        viewModel = RxSimpleViewModel(
            userName: usernameOutlet.rx.text.orEmpty.asObservable(),
            password: passwordOutlet.rx.text.orEmpty.asObservable()
        )
        
        viewModel.usernameValid.bind(to: usernameValidOutlet.rx.isHidden).disposed(by: disposeBag)
        viewModel.passwordValid.bind(to: passwordValidOutlet.rx.isHidden).disposed(by: disposeBag)
        viewModel.everythingValid.bind(to: doSomethingOutlet.rx.isEnabled).disposed(by: disposeBag)
        
    }
    
    @objc func btnAction() {
        print("1233")
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "RxSwift", message: "这是一个测试", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(ntfObserver!)
    }
    
}
