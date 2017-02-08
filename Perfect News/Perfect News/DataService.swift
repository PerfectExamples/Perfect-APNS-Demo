//
//  DataService.swift
//  Perfect News
//
//  Created by Ryan Collins on 2/8/17.
//  Copyright © 2017 Ryan Collins. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    fileprivate var _loadedNews = [NewsItem]()
    
    var loadedNews: [NewsItem] {
        get {
            return _loadedNews
        }
    }
    
    public func registerDeviceToken(deviceToken: Data) {
        
        let urlPath = "\(apiEndpoint)/register/device"
        guard let endpoint = URL(string: urlPath) else {
            print("Error creating endpoint")
            return
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        
        var payload = [String: Any]()
        payload["token"] = deviceToken
        
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: [])
            request.httpBody = data
        } catch {
            
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                NotificationCenter.default.post(Notification(name: .apiServerUnreachable))
            }
            
            do {
                guard let data = data else {
                    return
                }
                guard let jsonArr = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    return
                }
                
                
                if let error = jsonArr["error"] {
                    print("An error occurred: \(error)")
                    NotificationCenter.default.post(Notification(name: .addFailure))
                } else {
                    NotificationCenter.default.post(Notification(name: .addSuccessful))
                }
            } catch let err as NSError {
                print(err.debugDescription)
                NotificationCenter.default.post(Notification(name: .addFailure))
            }
        }.resume()
    }
    
    public func receiveNewItem() {
        
    }

}
