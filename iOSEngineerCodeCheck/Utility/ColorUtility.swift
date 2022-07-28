//
//  ColorUtility.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

struct ColorUtility {
    static func changeNabBarColor(navBar: UINavigationBar, color: UIColor) {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
        } else {
            navBar.barTintColor = color
            navBar.isTranslucent = false
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]// change title's color on navbar
        }

        navBar.tintColor = UIColor.white// change Button's color on navBar
    }
}
