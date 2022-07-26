//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchListViewController: UITableViewController {
    @IBOutlet private weak var searchBar: UISearchBar!

    private let viewModel = SearchListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = nil
        tableView.delegate = nil

        setupUI()
        setupViewModel()
    }

    private func setupUI() {
        searchBar.placeholder = "リポジトリ名で検索"
        tableView.register(SearchListCell.nib(), forCellReuseIdentifier: SearchListCell.identifier)
    }

    private func setupViewModel() {
        // MARK: - Inputs
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.inputs.searchBarText)
            .disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .bind(to: viewModel.inputs.searchButtonClicked)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .bind(to: viewModel.inputs.itemSelected)
            .disposed(by: disposeBag)

        // MARK: - Outputs
        viewModel.outputs.repoItems
            .bind(to: tableView.rx.items) { tableView, _, repoItem in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListCell.identifier) as? SearchListCell else {
                    return UITableViewCell()
                }
                cell.configure(avatarImageUrl: repoItem.owner.avatarUrl,
                               repoName: repoItem.fullName)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.outputs.transitionToRepoItemDetail
            .bind(to: transitionToRepoItemDetail)
            .disposed(by: disposeBag)
    }
}

// MARK: - Custom Binder
extension SearchListViewController {
    private var transitionToRepoItemDetail: Binder<RepoItem> {
        return Binder(self) { vc, repoItem in
            let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateInitialViewController() as! DetailViewController
            detailVC.repoItem = repoItem
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
