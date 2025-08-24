//
//  AddProductView.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 22/08/25.
//

import SwiftUI

struct AddProductView: View {
    @StateObject private var viewModel = AddProductViewModel()
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Nome do Comércio", text: $viewModel.location)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                TextField("Endereço", text: $viewModel.locario)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                TextField("R$ 0,00", text: $viewModel.price)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 250)
                        .overlay(Text("Nenhuma imagem selecionada").foregroundColor(.gray))
                        .cornerRadius(8)
                }

                HStack {
                    Button(action: { showCamera = true; imageSourceType = .camera }) {
                        Label("Câmera", systemImage: "camera")
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: { showImagePicker = true; imageSourceType = .photoLibrary }) {
                        Label("Galeria", systemImage: "photo")
                            .padding()
                            .background(Color.green.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                TextField("Descrição do Produto", text: $viewModel.description)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button(action: viewModel.sendProduct) {
                    if viewModel.isSending {
                        ProgressView()
                    } else {
                        Text("Enviar Produto")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.canSend ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .disabled(!viewModel.canSend || viewModel.isSending)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: Binding(
                get: { viewModel.image },
                set: { viewModel.image = $0 }
            ), sourceType: imageSourceType)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Aviso"),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("Ok")))
        }
    }
}



#Preview {
    AddProductView()
}
