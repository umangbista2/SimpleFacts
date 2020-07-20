//
//  FactsViewModel.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

protocol FactsViewModel: class {
    func fetchContent()
}


final class FactsViewModelImplementation: FactsViewModel {
    
    private let factsApiClient: FactsAPIProtocol
    
    init(factsApiClient: FactsAPIProtocol) {
        self.factsApiClient = factsApiClient
    }
    
    // MARK: FactsViewModel Protocol Implementation
    
    func fetchContent() {
        factsApiClient.getFacts { result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let factsData):
                print(factsData)
            }
        }
    }
}
