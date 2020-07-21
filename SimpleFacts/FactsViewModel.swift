//
//  FactsViewModel.swift
//  SimpleFacts
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import Foundation
import Reachability

/// Protocol: View Model Protocol for Facts View
protocol FactsViewModel: class {
    var view: FactsView? { get set }
    var title: String { get }
    var statusMessage: String { get set }

    func numberOfRows(inSection section: Int) -> Int
    func factForRow(atIndexPath indexPath: IndexPath) -> Fact
    
    func viewWillAppear()
    func fetchContent()
}


final class FactsViewModelImplementation: FactsViewModel {
    
    private let factsApiClient: FactsAPIProtocol
    
    init(factsApiClient: FactsAPIProtocol) {
        self.factsApiClient = factsApiClient
    }
    
    deinit {
        stopReachabilityNotifier()
    }
    
    private var factsData: FactsData? {
        didSet {
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
    
    private var facts: [Fact] { factsData?.rows ?? [] }

    private var reachability: Reachability?

    // MARK: - FactsViewModel Protocol Implementation
    
    weak var view: FactsView?
    
    var title: String { factsData?.title ?? "Facts unavailable" }
    
    var statusMessage: String = "loading..."
    
    
    func viewWillAppear() {
        setupReachability()
    }
    
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
                self.statusMessage = error.message
                self.factsData = nil
                
            case .success(let factsData):
                self.factsData = factsData
            }
        }
    }
    
}

// MARK: - Network Reachability

extension FactsViewModelImplementation {
    
    func setupReachability() {
        do {
            reachability = try Reachability()
        } catch {
            // Do not alert the for reachability errors
            print(error.localizedDescription)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged(_:)),
            name: .reachabilityChanged,
            object: reachability)
        
        startReachabilityNotifier()
    }
    
    func startReachabilityNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            // Do not alert the user for reachability errors
            print("could not start reachability notifier")
        }
    }
    
    func stopReachabilityNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection == .unavailable {
            print("reachabilityChanged: unavailable")
            view?.displayNoInternetStatus(true)
        } else {
            print("reachabilityChanged: available")
            fetchContent()
            view?.displayNoInternetStatus(false)
        }
    }
}
