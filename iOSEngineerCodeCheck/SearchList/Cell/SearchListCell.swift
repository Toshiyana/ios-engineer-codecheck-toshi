//
//  SearchListCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/25.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

final class SearchListCell: UITableViewCell {
    static let identifier = "SearchListCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var repoNameLabel: UILabel!

    func configure(avatarImageUrl: URL, repoName: String) {
        avatarImageView.kf.setImage(with: avatarImageUrl)
        repoNameLabel.text = repoName
    }
}
