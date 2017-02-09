//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectNotifications

// your app id. we use this as the configuration name, but they do not have to match
let notificationsAppId = "com.ryanmcollins.Perfect-News"

let apnsKeyIdentifier = "L5PQ5652T4"
let apnsTeamIdentifier = "8VF4S3W85G"
let apnsPrivateKey = "./keys/APNsAuthKey_L5PQ5652T4.p8"

NotificationPusher.addConfigurationAPNS(
    name: notificationsAppId,
    production: false, // should be false when running pre-release app in debugger, must be on device (emulator does not work)
    keyId: apnsKeyIdentifier,
    teamId: apnsTeamIdentifier,
    privateKeyPath: apnsPrivateKey)

func index(data: [String:Any]) throws -> RequestHandler {
    return {
        request, response in
        
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "Test")
        response.completed()
    }
}

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(data: [String:Any]) throws -> RequestHandler {
	return {
		request, response in

		response.setHeader(.contentType, value: "application/json")
		response.appendBody(string: DataService.instance.addDevice(withJSONRequest: request.postBodyString))
		response.completed()
	}
}

// Configuration data for two example servers.
// This example configuration shows how to launch one or more servers 
// using a configuration dictionary.

let port = 8181

let confData = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves the hello world message at <host>:<port>/
		//	* Serves static files out of the "./webroot"
		//		directory (which must be located in the current working directory).
		//	* Performs content compression on outgoing data when appropriate.
		[
			"name":"localhost",
			"port":port,
			"routes":[
                ["method":"get", "uri":"/", "handler":index],
                ["method":"get", "uri":"/notify", "handler":index],
				["method":"post", "uri":"/register/device", "handler":handler],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		],
	]
]

do {
	// Launch the servers based on the configuration data.
	try HTTPServer.launch(configurationData: confData)
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

