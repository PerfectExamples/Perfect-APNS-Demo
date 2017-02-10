//
//  DataService.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/8/17.
//
//

import Foundation
import PerfectLib
import PerfectNotifications

class DataService {
    
    static let instance = DataService()
    
    var devices = [Device]()
    
    func addDevice(withJSONRequest json: String?) -> String {
        var response = "{\"error\": \"An unknown error occured\"}"
        
        if let jsonStr = json {
            do {
                let dict = try jsonStr.jsonDecode() as! [String: Any]
                
                let token = dict["token"] ?? nil
                
                if let deviceToken = token as? String {
                    let device = Device(deviceToken)
                    
                    //Prevent Duplicates
                    if !devices.contains(device) {
                        devices.append(device)
                        response = "{\"success\": \"registered successfully\"}"
                        dump(device)
                    } else {
                        response = "{\"success\": \"already registered\"}"
                    }
                }
            } catch {
                print("Failed to add device token")
            }
        }
        
        return response
    }
    
    func notify(title: String, message: String) -> Bool {
        
        var deviceTokens = [String]()
        
        for device in devices {
            deviceTokens.append(device.deviceToken)
        }
        
        let n = NotificationPusher(apnsTopic: notificationsAppId)
        n.pushAPNS(
            configurationName: notificationsAppId,
            deviceTokens: deviceTokens,
            notificationItems: [.alertTitle(title), .alertBody(message), .sound("default")]) {
                responses in
                return parse(response: responses)
        }
    }
    
    func parse(response: String) -> Bool {
        return response.range(of: "200") != nil
    }
}
