//
//  Product.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 12/08/25.
//

import Foundation
import SwiftUI

struct Product: Identifiable, Codable {
    let id = UUID()
    let location: String
    let locario: String
    let price: Double
    let description: String
    let timestamp: String
    let image: String?
    let userName: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case location, locario, price, description, timestamp, image, userName, profileImage
    }
}
