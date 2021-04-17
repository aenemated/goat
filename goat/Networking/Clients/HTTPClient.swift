//
//  HTTPClient.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation

class HTTPClient {

    static let shared = HTTPClient()
    
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    
    func get(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: url)        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil, let result = data else { // Could always use better error handling
                completion(nil, error)
                return
            }
            completion(result, nil)
        })
        task.resume()
    }

}
