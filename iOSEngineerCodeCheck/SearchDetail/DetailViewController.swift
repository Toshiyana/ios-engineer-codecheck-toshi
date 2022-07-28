//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var accessPageButton: UIButton!

    @IBOutlet private weak var tableViewHeightConstant: NSLayoutConstraint! // ScrollView内におけるTableViewのHeightを自動調整するための変数

    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()

    var repoItem: RepoItem?
    private let infoName = ["Language", "Stars Count", "Watchers Count", "Forks Count",
                            "Open Issues Count"]
    private var infoValue: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let repoItem = repoItem {
            infoValue = [repoItem.language ?? "", "\(repoItem.stargazersCount)",
                         "\(repoItem.watchersCount)", "\(repoItem.forksCount)",
                         "\(repoItem.openIssuesCount)"]
        }

        setupUI()
        setupRx()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newSize = newValue as! CGSize
                tableViewHeightConstant.constant = newSize.height
            }
        }
    }

    private func setupUI() {
        if let repoItem = repoItem {
            titleLabel.text = repoItem.fullName
            iconImageView.kf.setImage(with: repoItem.owner.avatarUrl)
        }

        tableView.register(RepoInformationCell.nib(), forCellReuseIdentifier: RepoInformationCell.identifier)
        // 文字サイズを自動調整
        titleLabel.numberOfLines = 1
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    private func setupRx() {
        accessPageButton.rx.tap
            .subscribe({ [weak self] _ in
                guard let strongSelf = self,
                      let url = strongSelf.repoItem?.htmlUrl else { return }
                strongSelf.presentSafariViewController(for: url)
            })
            .disposed(by: disposeBag)
    }

    private func setupViewModel() {
        favoriteButton.rx.tap
            .subscribe { [weak self] _ in
                guard let strongSelf = self,
                      let repoItem = strongSelf.repoItem else { return }

                if strongSelf.favoriteButton.tag == 0 {
                    strongSelf.viewModel.inputs.addFavorite.accept(repoItem)
                } else {
                    strongSelf.viewModel.removeFavorite.accept("\(repoItem.id)")
                }
                strongSelf.activeButton(button: strongSelf.favoriteButton)
            }
            .disposed(by: disposeBag)

        viewModel.activeFavorite
            .subscribe { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.activeButton(button: strongSelf.favoriteButton)
            }
            .disposed(by: disposeBag)

        if let repoItem = repoItem {
            viewModel.getFavoriteCondition.accept("\(repoItem.id)")
        }
    }

    private func activeButton(button: UIButton) {
        if button.tag == 0 {
            button.tag = 1
            button.tintColor = .systemRed
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)

            //            button.backgroundColor = .systemOrange
            //            button.setTitle("お気に入りから削除", for: .normal)
            //            button.setTitleColor(.white, for: .normal)
        } else {
            button.tag = 0
            button.tintColor = .darkGray
            button.setImage(UIImage(systemName: "heart"), for: .normal)

            //            button.backgroundColor = .systemGray5
            //            button.setTitle("お気に入りに追加", for: .normal)
            //            button.setTitleColor(.black, for: .normal)
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoInformationCell.identifier, for: indexPath) as! RepoInformationCell

        guard let infoValue = infoValue else { return UITableViewCell() }
        cell.configure(infoName: infoName[indexPath.row],
                       infoValue: infoValue[indexPath.row])
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
