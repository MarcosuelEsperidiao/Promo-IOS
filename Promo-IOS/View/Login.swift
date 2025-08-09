//
//  ContentView.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 31/07/25.
//

import SwiftUI

struct Login: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: "#257E45").edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer().frame(height: 20)

                Text("Bem Vindo")
                    .font(.system(size: 30))
                    .foregroundColor(.white)

                Spacer().frame(height: 50)

                Text("Promo-App")
                    .font(.custom("Raleway-Medium", size: 40))
                    .bold()
                    .foregroundColor(.white)

                Spacer().frame(height: 60)

                TextField("Telefone", text: $viewModel.phone)
                    .onChange(of: viewModel.phone) { newValue in
                        viewModel.phone = newValue.formatPhoneNumber()
                    }
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .shadow(radius: 5)


                SecureField("Senha", text: $viewModel.password)
                    .padding()
                    .frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .shadow(radius: 5)

                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    viewModel.login()
                }) {
                    Text("Login")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#DADADA"))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)

                HStack {
                    Text("Já tem conta?")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                    Text("Cadastre-se!")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .bold()
                        .underline()
                }
                .padding(.top, 15)

                Spacer()

                HStack {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                        .padding(.leading, 20)

                    Text("Esqueceu a senha?")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .padding(.leading, 10)

                    Spacer()
                }
                .frame(height: 40)
                .padding(.bottom, 20)
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(title: Text("Erro"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    Login()
}
