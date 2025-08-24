import SwiftUI

struct PerfilUserView: View {
    @StateObject private var viewModel = PerfilUserViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Foto de perfil
            if let image = viewModel.decodeProfileImage() {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .padding(.top, 40)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            }

            // Nome do usuário
            Text("Olá, \(viewModel.userName)")
                .font(.system(size: 20, weight: .medium))

            Divider()
                .background(Color.green.opacity(0.6))
                .padding(.horizontal, 10)

            // Informações Pessoais
            Button(action: {}) {
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 25, height: 30)
                    Text("Informações Pessoais")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal)
            }

            // Configurações
            Button(action: {}) {
                HStack {
                    Image(systemName: "gear")
                        .frame(width: 25, height: 30)
                    Text("Configurações")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal)
            }

            // Termos e Condições
            Button(action: { viewModel.showingTermsAlert = true }) {
                HStack {
                    Image(systemName: "doc.text")
                        .frame(width: 25, height: 30)
                    Text("Termos e Condições")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal)
            }
            .alert(isPresented: $viewModel.showingTermsAlert) {
                Alert(
                    title: Text("Termos e Condições"),
                    message: Text("Aqui vão os termos e condições do app."),
                    dismissButton: .default(Text("Fechar"))
                )
            }

            Divider()
                .background(Color.green.opacity(0.6))
                .padding(.horizontal, 10)

            // Logout
            Button(action: { viewModel.showingLogoutAlert = true }) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .frame(width: 25, height: 30)
                    Text("Log out")
                        .foregroundColor(.red)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal)
            }
            .alert(isPresented: $viewModel.showingLogoutAlert) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Você realmente deseja sair?"),
                    primaryButton: .destructive(Text("Sim"), action: { viewModel.performLogout() }),
                    secondaryButton: .cancel()
                )
            }

            Spacer()
        }
    
    }
}

#Preview {
    PerfilUserView()
}
