//
//  LayoutUserView.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 02/08/25.
//

import SwiftUI

struct LayoutUserView: View {
    var userName: String {
        UserDefaults.standard.string(forKey: "userName") ?? "Usuário"
    }

    var body: some View {
        VStack {
            Text("Bem-vindo, \(userName)!")
                .font(.largeTitle)
                .padding()

            Button("Logout") {
                UserDefaults.standard.set(false, forKey: "isAuthenticated")
                UserDefaults.standard.removeObject(forKey: "userName")
                // reinicia o app ou volta pra LoginView
            }
            .foregroundColor(.red)
        }
    }
}
