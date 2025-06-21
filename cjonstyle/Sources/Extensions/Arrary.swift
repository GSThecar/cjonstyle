//
//  Arrary.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/22.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
