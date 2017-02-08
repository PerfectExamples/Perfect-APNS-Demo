//
//  DataService.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/8/17.
//
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    var devices = [Device]()
    
    func addDevice(withJSONRequest json: String) -> String {
        var response = "{\"error\": \"An unknown error occured\"}"
        
        do {
            let dict = try json.jsonDecode() as! [String: Any]
            
            let token = dict["token"] ?? nil
            
            if let deviceToken = token as? Data {
                let device = Device(deviceToken)
                devices.append(device)
                response = "{\"success\": true}"
            }
        } catch {
            print("Failed to add device token")
        }
        
        return response
    }
}
