//
//  Device.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/8/17.
//
//

import Foundation

class Device: Equatable {
    private var _deviceToken: String
    
    var deviceToken: String {
        get {
            return _deviceToken
        }
    }
    
    init(_ token: String) {
        _deviceToken = token
    }
    
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs._deviceToken == rhs._deviceToken
    }
}
