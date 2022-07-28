//
//  FavoriteViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class FavoriteViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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
}
