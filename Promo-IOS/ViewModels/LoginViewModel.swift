//
//  LoginViewModel.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 02/08/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var phone = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated = false

    private let service = AuthService()

    func login() {
        guard !phone.isEmpty, !password.isEmpty else {
            errorMessage = "Preencha todos os campos"
            return
        }

        guard phone.count >= 11 else {
            errorMessage = "Número de telefone inválido"
            return
        }

        guard password.count == 6 else {
            errorMessage = "Senha deve ter 6 dígitos"
            return
        }

        service.login(phone: phone, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(response.name, forKey: "userName")
                    self.isAuthenticated = true
                case .failure:
                    self.errorMessage = "Erro ao autenticar"
                }
            }
        }
    }
}

