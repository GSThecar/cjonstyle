//
//  WKWebViewModel.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

import RxCocoa
import RxSwift

final class WKWebViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: ControlEvent<Void>
    }
    struct Output {
        let shouldLoad: Observable<URLRequest>
    }

    private let initializedURL: BehaviorSubject<URL>

    init(with initializedURL: URL) {
        self.initializedURL = BehaviorSubject(value: initializedURL)
    }

    func transform(input: Input) -> Output {
        let shouldLoad = input.viewWillAppear.withLatestFrom(initializedURL) { URLRequest(url: $1) }
        return Output(shouldLoad: shouldLoad)
    }
}
