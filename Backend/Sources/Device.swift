//
//  Device.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/8/17.
//
//

import Foundation

class Device {
    private var _deviceToken: Data
    
    var deviceToken: Data {
        get {
            return _deviceToken
        }
    }
    
    init(_ token: Data) {
        _deviceToken = token
    }
}
