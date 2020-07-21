//
//  SimpleFactsTests.swift
//  SimpleFactsTests
//
//  Created by Umang Bista on 20/07/20.
//  Copyright © 2020 Umang. All rights reserved.
//

import XCTest
@testable import SimpleFacts

class SimpleFactsTests: XCTestCase {
    
    var factsViewModel: FactsViewModelImplementation!
    var mockApiClient: MockFactsAPIClient!

    override func setUp() {
        super.setUp()
        mockApiClient = MockFactsAPIClient()
        factsViewModel = FactsViewModelImplementation(factsApiClient: mockApiClient)
    }

    override func tearDown() {
        mockApiClient = nil
        factsViewModel = nil
        super.tearDown()
    }

    func test_factViewModelTitle() {
        factsViewModel.fetchContent()
        XCTAssertEqual(factsViewModel.title, "Facts Title")
    }
    
    func test_factsViewModelNumberOfRows() {
        factsViewModel.fetchContent()
        let rows = factsViewModel.numberOfRows(inSection: 0)
        
        XCTAssertEqual(rows, 3)
    }
    
    func test_factsRepsonseAPIRepsonse() {
        let factsAPIClient = FactsAPIClient()
        
        let expectation = self.expectation(description: "Check Facts API Response")
        
        var errorResponse: ApiError?
        
        factsAPIClient.getFacts { result in
            switch result {
            case .failure(let error):
                print("failure error: ", error.localizedDescription)
                errorResponse = error
            case .success(let result):
                print("result:", result)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(errorResponse, error.debugDescription)
        }
    }
}
