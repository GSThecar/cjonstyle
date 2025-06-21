//
//  PreFetchUseCase.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/22.
//

import Foundation

import Kingfisher
import RxSwift

final class PrefetchUseCase {
    func prefetchImages(for urls: [URL]) -> Observable<Bool> {
        return Observable.create { observer in
            Task {
                let result = await self.prefetchImagesAsync(for: urls)
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    private func prefetchImagesAsync(for urls: [URL]) async -> Bool {
        await withCheckedContinuation { continuation in
            let processor = DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
            let prefetcher = ImagePrefetcher(
                resources: urls,
                options: [.processor(processor)],
                progressBlock: nil,
                completionHandler: { _, failed, _ in
                    let isSuccess = failed.isEmpty
                    continuation.resume(returning: isSuccess)
                }
            )
            prefetcher.start()
        }
    }
}
