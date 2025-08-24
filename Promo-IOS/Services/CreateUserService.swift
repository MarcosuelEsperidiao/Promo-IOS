//
//  CreateUserService.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 22/08/25.
//

import Foundation

class CreateUserService {
    private let baseURL = "http://144.22.225.3:5000"
    
    func createUser(_ user: CreatUser, completion: @escaping (Result<Void, Error>) -> Void) {
        // Corrigido: usar o endpoint correto do backend
        guard let url = URL(string: baseURL + "/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    let err = NSError(domain: "", code: httpResponse.statusCode,
                                      userInfo: [NSLocalizedDescriptionKey: "Número já em uso ou erro no cadastro"])
                    completion(.failure(err))
                }
            }
        }.resume()
    }
}
