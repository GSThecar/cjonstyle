//
//  ViewModelType.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
