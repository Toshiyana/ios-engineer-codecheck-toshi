//
//  UIViewController+Extension.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertView(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
