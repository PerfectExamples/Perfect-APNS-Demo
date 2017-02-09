//
//  Handlers.swift
//  Perfect-APNS
//
//  Created by Ryan Collins on 2/9/17.
//
//

import Foundation

func indexHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "Test")
        response.completed()
    }
}

func registrationHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        
        response.setHeader(.contentType, value: "application/json")
        response.appendBody(string: DataService.instance.addDevice(withJSONRequest: request.postBodyString))
        response.completed()
    }
}

func notificationHandler(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response instance
        
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "Test")
        response.completed()
    }
}
