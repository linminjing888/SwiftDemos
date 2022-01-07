//
//  GithubSignupViewModel.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/1/5.
//

import RxSwift
import RxCocoa

class GithubSignupViewModel {
    
    let validatedUsername: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    let signupEnabled: Observable<Bool>
    let signedIn: Observable<Bool>
    let signingIn: Observable<Bool>

    init(input: (
            username: Observable<String>,
            password: Observable<String>,
            repeatedPassword: Observable<String>,
            loginTaps: Observable<Void>
        ),
        dependency:(
            API: GitHubAPI,
            validationService: GitHubValidationService,
            wireframe: Wireframe
        )
    ) {
        let API = dependency.API
        let validationService = dependency.validationService
        let wireFrame = dependency.wireframe
        
        validatedUsername = input.username
            .flatMapLatest({ username in
                return validationService.validateUsername(username)
                    .observe(on: MainScheduler.instance)
                    .catchAndReturn(.failed(message: "Error contacting server"))
            }).share(replay: 1)
        
        validatedPassword = input.password
            .map({ password in
                return validationService.validatePassword(password)
        }).share(replay: 1)
        
        validatedPasswordRepeated = Observable.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword).share(replay: 1)
        
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asObservable()
        
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) {(username: $0, password: $1)}
        
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest({ pair in
            return API.signup(pair.username, password: pair.password).observe(on: MainScheduler.instance).catchAndReturn(false).trackActivity(signingIn)
        }).flatMapLatest({ loggedIn -> Observable<Bool> in
            let message = loggedIn ? "Signed in to GitHub" : "Sign in to GitHub failed"
            return wireFrame.promptFor(message, cancelAction: "OK", actions: []).map { _ in
                loggedIn
            }
        }).share(replay: 1)
        
        signupEnabled = Observable.combineLatest(validatedUsername, validatedPassword,validatedPasswordRepeated,signingIn.asObservable()) {
            username,password,repeatPassword,signingIn in
            username.isValid && password.isValid && repeatPassword.isValid && !signingIn
        }.distinctUntilChanged().share(replay: 1)
    }
    
}
