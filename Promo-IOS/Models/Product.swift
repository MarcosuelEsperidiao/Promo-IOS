//
//  Product.swift
//  Promo-IOS
//
//  Created by Marcosuel Silva on 12/08/25.
//

import Foundation
import SwiftUI

struct Product: Codable {
    let location: String
    let locario: String
    let price: Double
    let image: String?
    let userName: String?
    let profileImage: String?
    let description: String
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case location, locario, price, image, userName, profileImage, description, timestamp
    }
}

