//
//  UIImageView+Loader.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(at url: String?) {
        guard
            let strURL = url,
            let url = URL(string: strURL)
            else { return }
        print("strURL: ", strURL)
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
