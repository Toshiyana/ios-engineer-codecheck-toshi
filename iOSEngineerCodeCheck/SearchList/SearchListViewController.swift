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
import Gifu

final class SearchListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private lazy var viewSpinner: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: view.frame.size.width,
                                        height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        return view
    }()

    private let viewModel = SearchListViewModel(githubAPI: GitHubAPI())
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

        searchBar.placeholder = "リポジトリ名で検索"
        searchBar.backgroundImage = UIImage() // 上下の線を除去

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

        viewModel.outputs.isLoadingSpinnerAvailable
            .subscribe(onNext: { [weak self] isAvailable in
                guard let strongSelf = self else { return }
                strongSelf.tableView.tableFooterView = isAvailable ? strongSelf.viewSpinner : UIView(frame: .zero)
            })
            .disposed(by: disposeBag)

        viewModel.outputs.errorResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                // TODO: エラー内容に応じたメッセージを表示したい
                strongSelf.showAlertView(title: "エラー", message: "通信エラーが発生しました")
            })
            .disposed(by: disposeBag)

        viewModel.outputs.deselectRow
            .bind(to: deselectRow)
            .disposed(by: disposeBag)

        tableView.rx.didScroll
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                let offsetY = strongSelf.tableView.contentOffset.y
                let contentHeight = strongSelf.tableView.contentSize.height

                if offsetY > (contentHeight - strongSelf.tableView.frame.size.height - 100) {
                    strongSelf.viewModel.outputs.fetchMoreData.accept(())
                }
            }
            .disposed(by: disposeBag)
    }

    private func setupLoadingHud(visible: Bool) {
        let imageSize = CGSize(width: 180, height: 180)
        let imageLoadingProgressView = GIFImageView(frame: CGRect(origin: CGPoint.zero, size: imageSize))
        imageLoadingProgressView.animate(withGIFNamed: "LoadingGif")

        PKHUD.sharedHUD.contentView = imageLoadingProgressView
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

    private var deselectRow: Binder<IndexPath> {
        return Binder(self) { vc, indexPath in
            vc.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
