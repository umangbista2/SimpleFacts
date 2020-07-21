//
//  APIType.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

/// API Type: A Type to group related APIs

protocol APIType {
    var endpoint: String { get }
    var method: String { get }
}
