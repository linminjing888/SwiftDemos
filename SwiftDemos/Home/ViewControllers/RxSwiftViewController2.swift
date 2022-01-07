//
//  RxSwiftViewController2.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/1/5.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 3
private let minimalPasswordLength = 6

class RxSwiftViewController2 : MJBaseViewController {
    
    let disposeBag = DisposeBag() // 垃圾袋
    
    private var usernameOutlet: UITextField!
    private var usernameValidOutlet: UILabel!

    private var passwordOutlet: UITextField!
    private var passwordValidOutlet: UILabel!
    
    private var repeatedPasswordOutlet: UITextField!
    private var repeatedPasswordValidationOutlet: UILabel!

    private var signupOutlet: UIButton!
    private var signingUpOulet: UIActivityIndicatorView!
    
    private var viewModel: GithubSignupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RxSwift"
        
        self.setupUI()
        
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
        usernameValidOutlet.text = "username validation"
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
        passwordValidOutlet.text = "password validation"
        passwordValidOutlet.textColor = .red
        view.addSubview(passwordValidOutlet)
        passwordValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 20))
        }
        
        repeatedPasswordOutlet = UITextField()
        repeatedPasswordOutlet.borderStyle = .roundedRect
        view.addSubview(repeatedPasswordOutlet)
        repeatedPasswordOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 45))
        }
        
        repeatedPasswordValidationOutlet = UILabel()
        repeatedPasswordValidationOutlet.text = "repeated password validation"
        repeatedPasswordValidationOutlet.textColor = .red
        view.addSubview(repeatedPasswordValidationOutlet)
        repeatedPasswordValidationOutlet.snp.makeConstraints { make in
            make.top.equalTo(repeatedPasswordOutlet.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 20))
        }
        
        signupOutlet = CustomButton(type: .custom)
        signupOutlet.backgroundColor = .cyan
        signupOutlet.layer.cornerRadius = 6
        signupOutlet.setTitle("Sign up", for: .normal)
        view.addSubview(signupOutlet)
        signupOutlet.snp.makeConstraints { make in
            make.top.equalTo(repeatedPasswordOutlet.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 45))
        }
//        doSomethingOutlet.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
//        signupOutlet.rx.tap.subscribe(onNext:  { [weak self] in
//            self?.showAlert()
//        }).disposed(by: disposeBag)
//
        signingUpOulet = UIActivityIndicatorView()
        view.addSubview(signingUpOulet)
        signingUpOulet.snp.makeConstraints { make in
            make.left.equalTo(signupOutlet.snp.left).offset(10)
            make.centerY.equalTo(signupOutlet)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
    }
    
    func setupMvvm() {
        
        viewModel = GithubSignupViewModel(input:
                                            (usernameOutlet.rx.text.orEmpty.asObservable(), passwordOutlet.rx.text.orEmpty.asObservable(), repeatedPasswordOutlet.rx.text.orEmpty.asObservable(), signupOutlet.rx.tap.asObservable()
                                            ), dependency:
                                            (GitHubDefaultAPI.sharedAPI,
                                             GitHubDefaultValidationService.sharedValidationService,
                                             DefaultWireframe.shared
                                            )
        )

        viewModel.signupEnabled.subscribe(onNext: { [weak self] valid in
            self?.signupOutlet.isEnabled = valid
            self?.signupOutlet.alpha = valid ? 1.0 : 0.5
        }).disposed(by: disposeBag)
        
        viewModel.validatedUsername.bind(to: usernameValidOutlet.rx.validationResult).disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .bind(to: passwordValidOutlet.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.validatedPasswordRepeated
            .bind(to: repeatedPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.signingIn.bind(to: signingUpOulet.rx.isAnimating).disposed(by: disposeBag)

        viewModel.signedIn.subscribe(onNext: {sign in
            print("User signed in \(sign)")
        }).disposed(by: disposeBag)
        
        let tapBg = UITapGestureRecognizer()
        tapBg.rx.event.subscribe(onNext: {[weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        view.addGestureRecognizer(tapBg)
        

        
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
    }
    
}
