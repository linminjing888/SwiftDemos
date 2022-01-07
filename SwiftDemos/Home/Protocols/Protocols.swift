//
//  Protocols.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/1/5.
//

import RxSwift
import SwiftUI

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

enum SignupState {
    case signedUp(signedUp: Bool)
}
// GitHub 网络服务
protocol GitHubAPI {
    
    func usernameAvailable(_ username: String) -> Observable<Bool>
    func signup(_ username: String, password: String) -> Observable<Bool>
}
// 输入验证服务
protocol GitHubValidationService {
    
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}
//// 弹框服务
//protocol Wireframe {
//    
//    func open(url: URL)
//    func promptFor<Action: CustomStringConvertible>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action>
//}


extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
    
}
