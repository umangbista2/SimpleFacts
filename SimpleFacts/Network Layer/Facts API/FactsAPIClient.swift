//
//  FactsAPIClient.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

class FactsAPIClient: FactsAPIProtocol {
    let networkLayer = NetworkLayer()
    
    func getFacts(completion: @escaping ((Swift.Result<FactsData, ApiError>) -> Void)) {
        networkLayer.request(api: FactsAPI.getAll, completion: completion)
    }
}
