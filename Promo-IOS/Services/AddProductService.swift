import Foundation
import SwiftUI

class AddProductService {
    private let baseURL = "http://144.22.225.3:5000/"
    
    func addProduct(_ product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL + "products") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(product)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("➡️ JSON enviado:", jsonString)
            }
            request.httpBody = data
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    completion(.success(()))
                } else {
                    let body = String(data: data ?? Data(), encoding: .utf8) ?? "Sem body"
                    print("❌ Erro servidor:", httpResponse.statusCode, body)
                    let err = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Erro ao enviar produto: \(body)"])
                    completion(.failure(err))
                }
            }
        }.resume()
    }
}
