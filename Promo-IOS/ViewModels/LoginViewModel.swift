import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var phone = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @AppStorage("userName") var userName: String = ""
    
    private let baseURL = "http://144.22.225.3:5000/"
    
    func login() {
        // Validações
        guard !phone.isEmpty, !password.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos!"
            return
        }
        guard phone.count >= 16 else {
            errorMessage = "O número de telefone deve ter no mínimo 11 dígitos"
            return
        }
        guard password.count == 6 else {
            errorMessage = "Dados inválidos"
            return
        }
        
        guard let url = URL(string: "\(baseURL)login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["phone": phone, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Erro: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self.errorMessage = "Dados inválidos"
                    return
                }
                
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    self.userName = loginResponse.name
                    self.isAuthenticated = true
                } catch {
                    self.errorMessage = "Erro ao processar resposta: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func logout() {
        self.isAuthenticated = false
        self.userName = ""
    }
}
