//
//  CellType+UITableViewCell.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

extension UITableViewCell: CellType {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
