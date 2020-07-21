//
//  MockFactsAPIClient.swift
//  SimpleFacts
//
//  Created by Umang Bista on 21/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

class MockFactsAPIClient: FactsAPIProtocol {
    let facts = [
        Fact(title: "Title1", description: "Description1", imageHref: nil),
        Fact(title: "Title2", description: "Description2", imageHref: nil),
        Fact(title: "Title3", description: "Description3", imageHref: nil)
    ]
    
    func getFacts(completion: @escaping ((Swift.Result<FactsData, ApiError>) -> Void)) {
        completion(.success(FactsData(title: "Facts Title", rows: facts)))
    }
}
