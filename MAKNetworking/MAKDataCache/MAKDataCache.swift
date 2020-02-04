//
//  MAKDataCache.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 04/02/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import Foundation

open class MAKDataCache {
    
    public static var instance = MAKDataCache(sizeInMB: 10 * 1024 * 1024)
    
    var cache = URLCache()
    
    public init(sizeInMB: Int) {
        print("DataCache initialized")
        cache = URLCache(memoryCapacity: sizeInMB, diskCapacity: 0, diskPath: nil)
    }
    
}

// MARK:- Store & Retreive data
extension MAKDataCache {
    
    /// Write data for request. This is an async operation.
    public func write(data: CachedURLResponse, forRequest request: URLRequest) {
        cache.storeCachedResponse(data, for: request)
    }
    
    /// Read data for request
    public func read(forRequest request: URLRequest) -> Data? {
        let data = cache.cachedResponse(for: request)?.data
        
        return data
    }

}
