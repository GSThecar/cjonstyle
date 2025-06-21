//
//  ProductUseCase.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import Foundation

import RxSwift

final class ProductUseCase{
    private let productDTOs: BehaviorSubject<[ProductDTO]> = BehaviorSubject(value: [])

    func fetch() async throws {
        guard
            let url = Bundle.main.url(forResource: "products",
                                  withExtension: "json")
        else {
            throw ProductFetchError.notExistFile
        }

        let data = try Data(contentsOf: url)
        let jsonParser = JSONDecoder()
        let decoded = try jsonParser.decode([ProductDTO].self, from: data)
        productDTOs.onNext(decoded)
    }

    func observableListMetadatas() -> Observable<[ListMetadata]> {
        productDTOs.map { dtos -> [ListMetadata] in
            dtos.compactMap { [weak self] dto -> ListMetadata? in
                guard
                    let imagePath = dto.image?.components(separatedBy: .whitespacesAndNewlines).joined(),
                    let thumbnailURL = URL(string: imagePath),
                    let price = self?.getMoney(from: dto.price)
                else { return nil }

                let name = dto.name ?? "-"

                return ListMetadata(thumbnailURL: thumbnailURL,
                                    name: name,
                                    price: price,
                                    link: dto.link?.components(separatedBy: .whitespacesAndNewlines).joined())
            }
        }
    }

    private func getMoney(from price: Int?) -> String {
        let initializeString = "-"
        guard let price = price else { return initializeString }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current

        return formatter.string(from: NSNumber(value: price)) ?? initializeString
    }
}
