//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsCountLabel: UILabel!
    @IBOutlet private weak var watchersCountLabel: UILabel!
    @IBOutlet private weak var forksCountLabel: UILabel!
    @IBOutlet private weak var openIssuesCountLabel: UILabel!

    var repoItem: RepoItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.numberOfLines = 1
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true

        setupUI()
    }

    private func setupUI() {
        if let repoItem = repoItem {
            titleLabel.text = repoItem.fullName
            languageLabel.text = "Written in \(repoItem.language)"
            starsCountLabel.text = "\(repoItem.stargazersCount) stars"
            watchersCountLabel.text = "\(repoItem.watchersCount) watchers"
            forksCountLabel.text = "\(repoItem.forksCount) forks"
            openIssuesCountLabel.text = "\(repoItem.openIssuesCount) open issues"
            iconImageView.kf.setImage(with: repoItem.owner.avatarUrl)
        }
    }
}
