import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct LayoutUserView: View {
    @StateObject private var viewModel = LayoutUserViewModel()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var headerHidden = false
    @State private var lastOffset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    
                    // HEADER
                    if !headerHidden {
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
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut, value: headerHidden)
                    }
                    
                    // CONTEÚDO ROLÁVEL
                    ScrollView {
                        VStack(spacing: 0) {
                            // marcador para voltar ao topo
                            Color.clear
                                .frame(height: 0)
                                .id("TOP")
                            
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named("scroll")).minY)
                            }
                            .frame(height: 0)
                            
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.products, id: \.timestamp) { product in
                                    ProductRow(product: product)
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                    .coordinateSpace(name: "scroll")
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        let delta = value - lastOffset
                        if delta < 0 && !headerHidden {
                            headerHidden = true
                        } else if delta > 0 && headerHidden {
                            headerHidden = false
                        }
                        lastOffset = value
                    }
                    .refreshable {
                        viewModel.fetchProducts()
                    }
                    
                    // BARRA INFERIOR
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                withAnimation {
                                    proxy.scrollTo("TOP", anchor: .top)
                                }
                            }) {
                                VStack {
                                    Image(systemName: "house")
                                    Text("INICIO").font(.caption)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        
                        NavigationLink(destination: AddProductView()) {
                            VStack {
                                Image(systemName: "plus.circle")
                                Text("ADICIONAR PRODUTO").font(.caption)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        
                        NavigationLink(destination: PerfilUserView()) {
                            VStack {
                                Image(systemName: "person")
                                Text("USUÁRIO").font(.caption)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
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
    }
}

#Preview {
    LayoutUserView()
}
