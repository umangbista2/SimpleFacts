//
//  ApiError.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

/// Custom Error Implementation for handling API Errors

enum ApiError: Error {
    case client
    case server
    case mimeType
    case decoding
    case encoding
    
    /// User readable message
    var message: String {
        "Some error occurred \n Pull to refresh "
    }
}
