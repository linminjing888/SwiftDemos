//
//  RxSimpleViewModel.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/1/4.
//

import RxSwift

private let minimalUsernameLength = 3
private let minimalPasswordLength = 6

class RxSimpleViewModel {
    
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>
    
    init(userName: Observable<String>, password: Observable<String>) {
        
        usernameValid = userName
            .map{ $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        passwordValid = password
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        everythingValid = Observable.combineLatest(usernameValid, passwordValid){$0 && $1}.share(replay: 1)
        
    }
    
    
}
