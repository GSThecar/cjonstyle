//
//  ListViewModel.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

import RxCocoa
import RxSwift

final class ListViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: ControlEvent<Void>
    }

    struct Output {
        let shouldFetch: Observable<Void>
        let listDataSource: Observable<[ListSectionMetadata]>
    }

    private let useCase: ProductUseCase

    init(with useCase: ProductUseCase) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        let shouldFetch = input.viewWillAppear
            .compactMap { [weak self] in self?.useCase.fetch }
            .flatMap { fetch in
                    Observable<Void>.create { observer in
                        Task {
                            do {
                                try await fetch()
                                observer.onNext(())
                                observer.onCompleted()
                            } catch {
                                observer.onError(error)
                            }
                        }
                        return Disposables.create()
                    }
                }

        let listDataSource = useCase.observableListMetadatas().map {
            [
                ListSectionMetadata(header: "TODO: 필요하다면, 타입변형도 가능",
                                    items: $0,
                                    footer: "TODO: 필요하다면 타입변형도 가능")
            ]
        }

        return Output(shouldFetch: shouldFetch,
                      listDataSource: listDataSource)
    }

}
