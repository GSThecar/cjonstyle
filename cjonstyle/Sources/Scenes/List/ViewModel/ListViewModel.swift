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
        let shouldPreFetch: ControlEvent<[IndexPath]>
        let didSelectRow: ControlEvent<IndexPath>
    }

    struct Output {
        let shouldFetch: Observable<Void>
        let startedPreFetch: Observable<Bool>
        let listDataSource: Observable<[ListSectionMetadata]>
        let shouldGoToWKWebView: Observable<WKWebViewModel?>
    }

    private let productUseCase: ProductUseCase
    private let preFetchUseCase: PrefetchUseCase
    

    init(productUseCase: ProductUseCase, preFetchUseCase: PrefetchUseCase) {
        self.productUseCase = productUseCase
        self.preFetchUseCase = preFetchUseCase
    }

    func transform(input: Input) -> Output {
        let shouldFetch = input.viewWillAppear
            .compactMap { [weak self] in self?.productUseCase.fetch }
            .flatMapLatest { fetch in
                Observable.create { observer in
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

        let listDataSource = productUseCase.observableListMetadatas().map {
            [
                ListSectionMetadata(header: "TODO: 필요하다면, 타입변형도 가능",
                                    items: $0,
                                    footer: "TODO: 필요하다면 타입변형도 가능")
            ]
        }

        let startedPreFetch = input.shouldPreFetch
            .withLatestFrom(listDataSource) { indexPaths, sections in
                indexPaths.compactMap {
                    sections[safe: $0.section]?.items[safe: $0.row]?.thumbnailURL
                }
            }
            .map { Array(Set($0)) }
            .flatMapLatest { [weak self] urls in
                guard let self else { return Observable<Bool>.just(false) }
                return self.preFetchUseCase.prefetchImages(for: urls)
            }

        let shouldGoToWKWebView = input.didSelectRow.withLatestFrom(listDataSource) { indexPath, datasource -> WKWebViewModel? in
            guard 
                let link = datasource[indexPath.section].items[indexPath.row].link,
                let linkURL = URL(string: link)
            else { return nil }
            return WKWebViewModel(with: linkURL)
        }

        return Output(shouldFetch: shouldFetch,
                      startedPreFetch: startedPreFetch,
                      listDataSource: listDataSource,
                      shouldGoToWKWebView: shouldGoToWKWebView)
    }

    
}
