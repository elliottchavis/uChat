//
//  LoginViewModel.swift
//  uChat
//
//  Created by agileassociates on 4/20/21.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
