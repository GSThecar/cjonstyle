//
//  UITableView.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

extension UITableView {
    func register<Cell> (cell: Cell.Type) where Cell: UITableViewCell {
        register(cell, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
}

