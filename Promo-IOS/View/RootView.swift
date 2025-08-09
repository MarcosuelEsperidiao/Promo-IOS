//
//  RootView.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 02/08/25.
//

import Foundation
import SwiftUI

struct RootView: View {
    @State private var isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")

    var body: some View {
        NavigationStack {
            if isAuthenticated {
                LayoutUserView()
            } else {
                Login()
            }
        }
    }
}
