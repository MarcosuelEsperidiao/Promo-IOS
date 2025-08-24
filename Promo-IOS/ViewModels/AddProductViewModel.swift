import SwiftUI
import CoreLocation
import UIKit

@MainActor
class AddProductViewModel: ObservableObject {
    @Published var location = ""
    @Published var locario = ""
    @Published var price = ""
    @Published var description = ""
    @Published var image: UIImage?
    @Published var isSending = false
    @Published var showAlert = false
    @Published var alertMessage = ""

    var canSend: Bool {
        !location.isEmpty && !locario.isEmpty && !price.isEmpty && image != nil
    }

    func sendProduct() {
        guard let priceFloat = Float(price),
              let image = image else {
            alertMessage = "Preencha todos os campos corretamente."
            showAlert = true
            return
        }

        isSending = true
        let timestamp = ISO8601DateFormatter().string(from: Date())

        guard let imageBase64 = image.jpegData(compressionQuality: 0.2)?.base64EncodedString() else {
            alertMessage = "Erro ao processar imagem."
            showAlert = true
            return
        }

        let userDefaults = UserDefaults.standard
        guard let userName = userDefaults.string(forKey: "userName") else {
            alertMessage = "Usuário não encontrado."
            showAlert = true
            return
        }
        let profileImage = userDefaults.string(forKey: "profileImage")

        let product = Product(
            location: location,
            locario: locario,
            price: Double(priceFloat),
            image: imageBase64,
            userName: userName,
            profileImage: profileImage,
            description: description,
            timestamp: timestamp
        )


        AddProductService().addProduct(product) { [weak self] result in
            DispatchQueue.main.async {
                self?.isSending = false
                switch result {
                case .success():
                    self?.alertMessage = "Produto enviado com sucesso!"
                    self?.clearForm()
                case .failure(let error):
                    self?.alertMessage = "Erro: \(error.localizedDescription)"
                }
                self?.showAlert = true
            }
        }
    }

    private func clearForm() {
        location = ""
        locario = ""
        price = ""
        description = ""
        image = nil
    }
}
