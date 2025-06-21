//
//  ViewType.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import RxSwift

protocol ViewType: AnyObject {
    associatedtype ViewModel = ViewModelType
    var disposeBag: DisposeBag! { get set }
    var viewModel: ViewModel! { get set }
    func setupUI()
    func setupLayout()
    func setupBinding()
}
