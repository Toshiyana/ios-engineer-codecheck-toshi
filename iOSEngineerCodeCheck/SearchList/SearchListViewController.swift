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
import PKHUD

final class SearchListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private let viewModel = SearchListViewModel(githubAPI: GitHubAPI())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

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

        viewModel.outputs.isLoadingHudAvailable
            .map { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.setupLoadingHud(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)

        viewModel.outputs.errorResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                // TODO: エラー内容に応じたメッセージを表示したい
                strongSelf.showAlertView(title: "エラー", message: "通信エラーが発生しました")
            })
            .disposed(by: disposeBag)
    }

    private func setupLoadingHud(visible: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        visible ? PKHUD.sharedHUD.show(onView: view) : PKHUD.sharedHUD.hide()
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
