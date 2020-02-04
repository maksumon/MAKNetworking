//
//  MAKNetworkingTests.swift
//  MAKNetworkingTests
//
//  Created by Mohammad Ashraful Kabir on 26/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import XCTest
@testable import MAKNetworking

class MAKNetworkingTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetPostsWithExpectedURL() {
        let postFetcher = PostFetcher()
        
        XCTAssertEqual(API_URL, "https://pastebin.com/raw/wgkJgazE")
        
        let postsExpectation = expectation(description: "posts")
        var posts: [Post]?
        
        postFetcher.getData(fromUrl: API_URL) { (result, error) in
            posts = result
            postsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(posts)
        }
    }
    
    func testGetPostsWhenResponseReturnsError() {
        let postFetcher = PostFetcher()
      
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        
        postFetcher.getData(fromUrl: "") { (result, error) in
            errorResponse = error
            errorExpectation.fulfill()
        }
      
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }

    func testCachePosts() {
        let cacheExpectation = expectation(description: "cache")
        var cacheData: Data?
        
        let url = URL(string: API_URL)!
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else {
                print(error!)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(response.debugDescription)
                return
            }
            
            let cachedData = CachedURLResponse(response: response!, data: data)
            MAKDataCache.instance.write(data: cachedData, forRequest: request)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                cacheData = MAKDataCache.instance.read(forRequest: request)
                cacheExpectation.fulfill()
            })
        }).resume()
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(cacheData)
        }
    }
    
}
