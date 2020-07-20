//
//  ApiError.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case client
    case server
    case mimeType
    case parse
}
