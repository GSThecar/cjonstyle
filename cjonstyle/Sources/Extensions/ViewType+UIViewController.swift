//
//  ViewType+UIViewController.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

import RxSwift

extension ViewType where Self: UIViewController {
    static func create(with viewModel: ViewModel) -> Self {
        let `self` = Self()
        self.disposeBag = DisposeBag()
        self.viewModel = viewModel
        self.setupUI()
        self.setupLayout()
        self.setupBinding()
        return self
    }
}
