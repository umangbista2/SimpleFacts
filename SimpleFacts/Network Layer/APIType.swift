//
//  APIType.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

protocol APIType {
    var endpoint: String { get }
    var method: String { get }
}
