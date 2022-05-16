//
//  RxSwiftViewController3.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/3/4.
//

import RxSwift
import RxCocoa

class RxSwiftViewController3 : MJBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let disposeBag = DisposeBag()

        let sequence = Observable<String>.create { observer in
            observer.onNext("🍎")
            observer.onNext("🍐")
            observer.onCompleted()
            return Disposables.create()
        }

        sequence
            .debug("Fruit")
            .subscribe()
            .disposed(by: disposeBag)
        
    }

}
