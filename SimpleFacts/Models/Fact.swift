//
//  Fact.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

/// Simple Fact

struct Fact: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}
