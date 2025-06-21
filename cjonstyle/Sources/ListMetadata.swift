//
//  ListMetadata.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

struct ListMetadata {
    let thumbnailURL: URL
    let name: String
    let price: String
    var didTap: ((URL) -> Void)?
}
