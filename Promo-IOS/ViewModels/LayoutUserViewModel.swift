//
//  LayoutUserViewModel.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 12/08/25.
//

import Foundation
import SwiftUI

class LayoutUserViewModel: ObservableObject {
    @Published var user = User(name: "usuário", profileImageBase64: nil)
    @Published var products: [Product] = []
    @Published var isRefreshing = false
    
    private let baseURL = URL(string: "http://144.22.225.3:5000/")!
    
    init() {
        loadUser()
        loadProfileImage()
        fetchProducts()
    }
    
    func loadUser() {
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            user.name = savedName
        }
    }
    
    func saveUserName(_ name: String) {
        user.name = name
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    func saveProfileImage(_ image: UIImage) {
        if let data = image.pngData() {
            let base64String = data.base64EncodedString()
            user.profileImageBase64 = base64String
            UserDefaults.standard.set(base64String, forKey: "profileImage")
        }
    }
    
    func loadProfileImage() {
        if let base64String = UserDefaults.standard.string(forKey: "profileImage") {
            user.profileImageBase64 = base64String
        }
    }
    
    func fetchProducts() {
        isRefreshing = true
        let endpoint = baseURL.appendingPathComponent("products") // Ajustar rota se necessário
        
        URLSession.shared.dataTask(with: endpoint) { data, _, error in
            DispatchQueue.main.async {
                self.isRefreshing = false
            }
            
            if let error = error {
                print("Erro ao buscar produtos:", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.products = products
                }
            } catch {
                print("Erro no decode:", error.localizedDescription)
            }
        }.resume()
    }
}

