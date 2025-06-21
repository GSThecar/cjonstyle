//
//  ListViewController.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

import Kingfisher
import RxCocoa
import RxDataSources
import RxSwift

final class ListViewController: UIViewController, ViewType {
    typealias ViewModel = ListViewModel

    var disposeBag: DisposeBag!
    var viewModel: ViewModel!

    private let tableView: UITableView = UITableView().then {
        $0.register(cell: ListTableViewCell.self)
    }
    private let datasource: RxTableViewSectionedReloadDataSource<ListSectionMetadata> = RxTableViewSectionedReloadDataSource { datasource, tableView, indexPath, item in
        let cell = tableView.dequeue(ListTableViewCell.self, for: indexPath)
        cell?.update(with: item)
        return cell ?? UITableViewCell()
    }

    func setupUI() {
        view.addSubview(tableView)
    }

    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.directionalEdges.equalTo(view.safeAreaLayoutGuide.snp.directionalEdges)
        }
    }

    func setupBinding() {
        let input = ViewModel.Input(viewWillAppear: rx.viewWillAppear,
                                    didSelectRow: tableView.rx.itemSelected)

        let output = viewModel.transform(input: input)

        output.shouldFetch.subscribe(onNext: {
            #if DEBUG
            print(#function, "성공")
            #endif
        }, onError: { error in
            #if DEBUG
            print(#function, error)
            #endif
        })
        .disposed(by: disposeBag)

        output.listDataSource.asDriver(onErrorDriveWith: .empty()).drive {
            $0.bind(to: tableView.rx.items(dataSource: datasource))
        }.disposed(by: disposeBag)

        output.shouldGoToWKWebView.asDriver(onErrorDriveWith: .empty()).drive { [weak self] viewModel in
            if let viewModel = viewModel {
                self?.navigationController?.pushViewController(WKWebViewController.create(with: viewModel), animated: true)
                return
            }

            #if DEBUG
            print(#function, "linkURL 없음")
            #endif
        }.disposed(by: disposeBag)

        tableView.rx.prefetchRows
            .withLatestFrom(output.listDataSource) { ($0, $1) }
            .subscribe(onNext: { indexPaths, datasource in
                let urls = Set(indexPaths.map { datasource[$0.section].items[$0.row].thumbnailURL })
                let processor = DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))
                ImagePrefetcher(resources: Array(urls), options: [.processor(processor)]).start()
            })
            .disposed(by: disposeBag)

        tableView.rx.willDisplayCell.withLatestFrom(output.listDataSource) { ($0, $1) }
            .subscribe(onNext: { cellWithIndexPath, datasource in
                guard let cell = cellWithIndexPath.cell as? ListTableViewCell else { return }
                let thumbnailURL = datasource[cellWithIndexPath.indexPath.section].items[cellWithIndexPath.indexPath.row].thumbnailURL
                cell.preFetchThumbnail(with: thumbnailURL)
            })
            .disposed(by: disposeBag)
    }

}

