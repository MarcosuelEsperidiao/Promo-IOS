//
//  CreateUserViewModel.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 22/08/25.
//

import SwiftUI

class CreateUserViewModel: ObservableObject {
    @Published var name = ""
    @Published var phone = ""
    @Published var password = ""
    @Published var message: String?
    @Published var success = false
    
    private let service = CreateUserService()
    
    func formatPhoneNumber(_ number: String) -> String {
        let digits = number.filter { $0.isNumber }
        switch digits.count {
        case 0: return ""
        case 1...2: return "(\(digits))"
        case 3...7:
            let ddd = String(digits.prefix(2))
            let rest = String(digits.dropFirst(2))
            return "(\(ddd)) \(rest)"
        case 8...11:
            let ddd = String(digits.prefix(2))
            let first = String(digits.dropFirst(2).prefix(1))
            let mid = String(digits.dropFirst(3).prefix(4))
            let end = String(digits.dropFirst(7))
            return "(\(ddd)) \(first) \(mid)-\(end)"
        default:
            return number
        }
    }
    
    func createUser() {
        guard !name.isEmpty, !phone.isEmpty, !password.isEmpty else {
            message = "Por favor, preencha todos os campos"
            return
        }
        
        if phone.count < 16 {
            message = "O número de telefone deve ter no mínimo 11 dígitos"
            return
        }
        
        if password.count != 6 {
            message = "A senha deve ter 6 dígitos"
            return
        }
        
        let user = CreatUser(name: name, phone: phone, password: password)
        
        service.createUser(user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.success = true
                    self?.message = "Conta criada com sucesso"
                case .failure(let error):
                    self?.message = error.localizedDescription
                }
            }
        }
    }
}
