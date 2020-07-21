//
//  UITableView+message.swift
//  SimpleFacts
//
//  Created by Umang Bista on 21/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setMessage(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        label.sizeToFit()
        
        separatorStyle = .none
        backgroundView = label
    }
    
    func removeMessage() {
        separatorStyle = .singleLine
        backgroundView = nil
    }
}
