//
//  APIManager.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 27/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import Foundation

class APIManager<T: Decodable> {
    
    func getData(fromUrl url: String, onComplete: @escaping (T?, Error?)-> Void) {
        if url != "" {
            let url = URL(string: url)!
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
            
            if let data = MAKDataCache.instance.read(forRequest: request) {
                let decoded = try? JSONDecoder().decode(T?.self, from: data)
                onComplete(decoded, nil)
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let data = data else {
                        print(error!)
                        onComplete(nil, error!)
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print(response.debugDescription)
                        onComplete(nil, error!)
                        return
                    }
                    
                    let cachedData = CachedURLResponse(response: response!, data: data)
                    MAKDataCache.instance.write(data: cachedData, forRequest: request)
                    
                    let decoded = try? JSONDecoder().decode(T?.self, from: data)
                    onComplete(decoded, nil)
                }).resume()
            }
        } else {
            let error = NSError(domain: "Url string cannot be nil!", code: 1234, userInfo: nil)
            onComplete(nil, error)
        }
    }
    
}

typealias PostFetcher = APIManager<[Post]>
