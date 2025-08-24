//
//  ProductRow.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 21/08/25.
//
import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Cabeçalho: Foto + Nome + Data
            HStack(alignment: .center) {
                if let base64 = product.profileImage?
                  .replacingOccurrences(of: "\n", with: "")
                  .replacingOccurrences(of: "\r", with: "")
                  .replacingOccurrences(of: "data:image/png;base64,", with: ""),
                   let data = Data(base64Encoded: base64),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                
                
                Text(product.userName ?? "Usuário")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 8)

                Spacer()
                
                Text(product.timestamp)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
            
            // Local
            Text(product.location)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
            // Endereço
            Text(product.locario)
                .font(.system(size: 18))
                .foregroundColor(.black)
            
            // Preço
            Text("R$ \(product.price, specifier: "%.2f")")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            // Imagem principal
            if let base64 = product.image {
                if let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                } else {
                    Text("Falha ao carregar imagem")
                        .foregroundColor(.red)
                }
            }

            
            // Descrição
            Text(product.description)
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            Divider()
                .padding(.top, 12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
        .padding(.horizontal)
    }
}




