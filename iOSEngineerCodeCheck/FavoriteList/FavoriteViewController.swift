//
//  FavoriteViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift

final class FavoriteViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = FavoriteViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()
    }

    private func setupUI() {
        // NavBarの色を変える
        guard let navBar = navigationController?.navigationBar else {
            fatalError("NavigationController does not exist.")
        }
        ColorUtility.changeNabBarColor(navBar: navBar, color: .darkGray)

        // iOS15用のTabBarを設定
        guard let tabBar = tabBarController?.tabBar else {
            fatalError("NavigationController does not exist.")
        }
        TabBarUtility.set(tabBar: tabBar)
    }
    
    private func setupViewModel() {
        // MARK: - Inputs
        tableView.rx.itemSelected
            .bind(to: viewModel.inputs.itemSelected)
            .disposed(by: disposeBag)

        // MARK: - Outputs
        viewModel.outputs.repoItems
            .bind(to: tableView.rx.items) { tableView, _, repoItemObject in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListCell.identifier) as? SearchListCell else {
                    return UITableViewCell()
                }
                cell.configure(avatarImageUrl: repoItemObject.ownerAvatarUrl,
                               repoName: repoItemObject.fullName)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.outputs.transitionToRepoItemDetail
            .bind(to: transitionToRepoItemDetail)
            .disposed(by: disposeBag)

        viewModel.outputs.deselectRow
            .bind(to: deselectRow)
            .disposed(by: disposeBag)
    }
}

// MARK: - Custom Binder
extension FavoriteViewController {
    private var transitionToRepoItemDetail: Binder<RepoItemObject> {
        return Binder(self) { vc, repoItem in
            let detailVC = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateInitialViewController() as! DetailViewController
            detailVC.repoItem = repoItem
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    private var deselectRow: Binder<IndexPath> {
        return Binder(self) { vc, indexPath in
            vc.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
