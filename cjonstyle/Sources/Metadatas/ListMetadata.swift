//
//  ListMetadata.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

import RxDataSources

extension ListSectionMetadata {
    init(original: ListSectionMetadata, items: [ListMetadata]) {
        self = original
        self.items = items
    }
}

struct ListSectionMetadata: SectionModelType {
    let header: String
    var items: [ListMetadata]
    let footer: String
}

struct ListMetadata {
    let thumbnailURL: URL
    let name: String
    let price: String
    var didTap: ((URL) -> Void)?
}
