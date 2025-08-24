//
//  RootView.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 23/08/25.
//

import Foundation
import SwiftUI


struct RootView: View {
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        if loginVM.isAuthenticated {
            LayoutUserView()
                .environmentObject(loginVM)
        } else {
            Login()
                .environmentObject(loginVM)
        }
    }
}
