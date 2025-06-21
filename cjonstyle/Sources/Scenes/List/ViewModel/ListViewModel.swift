//
//  ListViewModel.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

final class ListViewModel: ViewModelType {
    struct Input {
    }

    struct Output {
        
    }

    let useCase: ProductUseCase

    init(with useCase: ProductUseCase) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        Output()
    }

}
