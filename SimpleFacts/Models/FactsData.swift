//
//  FactsData.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

/// Model to handle facts api response data

struct FactsData: Decodable {
    var title: String?
    var rows: [Fact]?
}
