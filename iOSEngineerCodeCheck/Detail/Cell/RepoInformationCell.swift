//
//  RepoInformationCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepoInformationCell: UITableViewCell {
    static let identifier = "RepoInformationCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet private weak var infoNameLabel: UILabel!
    @IBOutlet private weak var infoValueLabel: UILabel!

    func configure(infoName: String, infoValue: String) {
        infoNameLabel.text = infoName
        infoValueLabel.text = infoValue
    }
}
