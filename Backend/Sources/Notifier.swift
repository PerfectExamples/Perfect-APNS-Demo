//
//  Notifier.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/10/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

struct Notifier {
    func notify(withJSONRequest json: String) -> String {
        var response = "{\"Error\": \"Failed to invoke notification\"}"
        
        do {
            let dict = try json.jsonDecode() as! [String: String]
            
            if let title = dict["title"], let message = dict["message"] {
                DataService.instance.notify(title: title, message: message)
                response = "{\"success\": true}"
            }
        } catch {
            print("Failed to decode JSON")
        }
        
        return response
    }
}
