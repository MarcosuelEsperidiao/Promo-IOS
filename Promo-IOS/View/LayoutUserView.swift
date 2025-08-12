import SwiftUI

struct LayoutUserView: View {
    @StateObject private var viewModel = LayoutUserViewModel()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            // Topo
            VStack {
                Text("Promo-App")
                    .font(.custom("Raleway-Medium", size: 30))
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                HStack(spacing: 15) {
                    if let base64 = viewModel.user.profileImageBase64,
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
                            .onTapGesture { showingImagePicker = true }
                    }
                    
                    Text("Olá, \(viewModel.user.name)")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                    .background(Color.green.opacity(0.8))
                    .padding(.top, 20)
            }
            .background(Color(hex: "#257E45"))
            
            // Lista de produtos
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.products) { product in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(product.location)
                                .bold()
                            
                            Text("Endereço: \(product.locario)")
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("Preço: R$ \(product.price, specifier: "%.2f")")
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("Descrição: \(product.description)")
                                .bold()
                                .foregroundColor(.black)
                            
                            Text(product.timestamp)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
                .padding()
            }
            .refreshable {
                viewModel.fetchProducts()
            }
            
            // Barra inferior
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "house")
                    Text("INICIO").font(.caption)
                }
                Spacer()
                VStack {
                    Image(systemName: "plus.circle")
                    Text("ADICIONAR PRODUTO").font(.caption)
                }
                Spacer()
                VStack {
                    Image(systemName: "person")
                    Text("USUÁRIO").font(.caption)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
                .onDisappear {
                    if let img = selectedImage {
                        viewModel.saveProfileImage(img)
                    }
                }
        }
    }
}

#Preview {
    LayoutUserView()
}
