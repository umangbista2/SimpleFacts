//
//  UIViewController+alert.swift
//  SimpleFacts
//
//  Created by Umang Bista on 21/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(type: UIAlertController.Style, title: String, message: String, buttonText: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: type)
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel){ _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
