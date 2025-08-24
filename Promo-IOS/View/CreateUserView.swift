//
//  CreateUserView.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 22/08/25.
//

import SwiftUI

struct CreateUserView: View {
    @StateObject private var viewModel = CreateUserViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.green, Color.blue]),
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Criar Conta")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                TextField("Primeiro Nome", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("Celular", text: Binding(
                    get: { viewModel.phone },
                    set: { viewModel.phone = viewModel.formatPhoneNumber($0) }
                ))
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                SecureField("Senha", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text("A senha deve ter 6 dígitos")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.caption)
                
                Button(action: {
                    viewModel.createUser()
                }) {
                    Text("Criar conta")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if let message = viewModel.message {
                    Text(message)
                        .foregroundColor(viewModel.success ? .green : .red)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $viewModel.success) {
            Alert(
                title: Text("Sucesso"),
                message: Text("Conta criada com sucesso"),
                dismissButton: .default(Text("OK")) {
                    dismiss() // volta pra tela de login
                }
            )
        }
    }
}

#Preview {
    CreateUserView()
}
