//
//  FactsAPI.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

enum FactsAPI: APIType {
    case getAll
    
    var endpoint: String {
        switch self {
        case .getAll:
            return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        }
    }
    
    var method: String {
        switch self {
        case .getAll:
            return "GET"
        }
    }
}
