//
//  ListViewController.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

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
        let input = ViewModel.Input(viewWillAppear: rx.viewWillAppear)
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
    }

}

