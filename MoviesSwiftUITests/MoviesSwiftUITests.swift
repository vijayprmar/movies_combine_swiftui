//
//  MoviesSwiftUITests.swift
//  MoviesSwiftUITests
//
//  Created by Vijay Parmar on 04/12/23.
//

import XCTest
import Combine

final class MoviesSwiftUITests: XCTestCase {

    private var cancellables : Set<AnyCancellable> = []
    
    func testFetchMovies() throws{
        
        let httpClient = HTTPClient()
        
        let expecctation = XCTestExpectation(description: "Recieved mmovies")
        
        httpClient.fetchMovies(search: "Batman")
            .sink { completion in
                switch completion{
                case .finished :break
                case.failure(let error):
                    XCTFail("Request failed with error \(error)")
                }
            } receiveValue: { movies in
                XCTAssert(movies.count > 0)
                expecctation.fulfill()
            }.store(in: &cancellables)
        wait(for: [expecctation],timeout: 5.0)
    }
    
}
