//
//  ProductDTO.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

struct ProductDTO: Decodable {
    let id: String?
    let name: String?
    let brand: String?
    let price: Int?
    let discountPrice: Int?
    let discountRate: Int?
    let image: String?
    let link: String?
    let tags: [String?]?
    let benefits: [String?]?
    let rating: Double?
    let reviewCount: Int?
}
