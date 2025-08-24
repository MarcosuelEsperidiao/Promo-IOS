//
//  PerfilUserViewModel.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 23/08/25.
//

import SwiftUI
import Combine

class PerfilUserViewModel: ObservableObject {
    @AppStorage("userName") var userName: String = "usuário"
    @AppStorage("profileImage") var profileImageBase64: String = ""
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false

    @Published var showingLogoutAlert = false
    @Published var showingTermsAlert = false

    func decodeProfileImage() -> UIImage? {
        guard !profileImageBase64.isEmpty,
              let data = Data(base64Encoded: profileImageBase64),
              let image = UIImage(data: data) else { return nil }
        return image
    }

    func performLogout() {
        profileImageBase64 = ""
        userName = ""
        isAuthenticated = false
    }
}
