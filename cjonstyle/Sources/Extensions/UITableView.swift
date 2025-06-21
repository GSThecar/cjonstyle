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
    func dequeue<Cell> (_ reusableCell: Cell.Type, for indexPath: IndexPath) -> Cell? where Cell: UITableViewCell {
        dequeueReusableCell(withIdentifier: reusableCell.reuseIdentifier, for: indexPath) as? Cell
    }
}

