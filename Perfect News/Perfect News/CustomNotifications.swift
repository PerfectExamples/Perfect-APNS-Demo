//
//  CustomNotifications.swift
//  Perfect News
//
//  Created by Ryan Collins on 2/8/17.
//  Copyright © 2017 Ryan Collins. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let apiServerUnreachable = Notification.Name("apiServerUnreachable")
    static let addFailure = Notification.Name("addFailure")
    static let addSuccessful = Notification.Name("addSuccessful")
    static let itemsLoaded = Notification.Name("itemsLoaded")
}
