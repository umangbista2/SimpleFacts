//
//  FactsViewModel.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation

protocol FactsViewModel: class {
    var view: FactsView? { get set }

    func numberOfRows(inSection section: Int) -> Int
    func factForRow(atIndexPath indexPath: IndexPath) -> Fact
    
    func fetchContent()
}


final class FactsViewModelImplementation: FactsViewModel {
    
    private let factsApiClient: FactsAPIProtocol
    
    init(factsApiClient: FactsAPIProtocol) {
        self.factsApiClient = factsApiClient
    }
    
    private var factsData: FactsData? {
        didSet {
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
    
    private var facts: [Fact] { factsData?.rows ?? [] }

    // MARK: FactsViewModel Protocol Implementation
    
    weak var view: FactsView?
    
    func numberOfRows(inSection section: Int) -> Int {
        return facts.count
    }
    
    func factForRow(atIndexPath indexPath: IndexPath) -> Fact {
        return facts[indexPath.row]
    }
    
    func fetchContent() {
        factsApiClient.getFacts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.factsData = nil
                print(error)
                
            case .success(let factsData):
                self.factsData = factsData
            }
        }
    }
}
