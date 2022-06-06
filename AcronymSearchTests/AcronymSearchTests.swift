//
//  AcronymSearchTests.swift
//  AcronymSearchTests
//
//  Created by Rajesh Sammita on 6/6/22.
//

import XCTest
@testable import AcronymSearch

class AcronymSearchTests: XCTestCase {

    var viewModel: AcronymListViewModel?
    var mockAPIServiceMovieList: MockAPIAcronymSearch!

    override func setUp() {
        super.setUp()
        mockAPIServiceMovieList = MockAPIAcronymSearch()
        viewModel = AcronymListViewModel(apiService: mockAPIServiceMovieList)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        let expect = XCTestExpectation(description: "callback")
        viewModel?.fetchLongFormList(searchText: "HDA") { dataObject in
            expect.fulfill()
            XCTAssertNotEqual( dataObject.value?.longFormList?.count, 0)
            for movieObject in dataObject.value?.longFormList ?? [] {
                XCTAssertNotNil(movieObject.longForm)
            }
        }
        wait(for: [expect], timeout: 1)
    }

}

