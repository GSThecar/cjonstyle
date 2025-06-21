//
//  WKWebViewController.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit
import WebKit

import RxCocoa
import RxSwift

final class WKWebViewController: UIViewController, ViewType {
    typealias ViewModel = WKWebViewModel
    var disposeBag: DisposeBag!
    var viewModel: ViewModel!

    private let wkWebView: WKWebView = WKWebView()

    func setupUI() {
        view.addSubview(wkWebView)
    }
    func setupLayout() {
        wkWebView.snp.makeConstraints {
            $0.directionalEdges.equalTo(view.safeAreaLayoutGuide.snp.directionalEdges)
        }
    }
    func setupBinding() {
        let input = ViewModel.Input(viewWillAppear: rx.viewWillAppear)
        let output = viewModel.transform(input: input)

        output.shouldLoad.subscribe { [weak self] request in
            self?.wkWebView.load(request)
        }.disposed(by: disposeBag)
    }
}
