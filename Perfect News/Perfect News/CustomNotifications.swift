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
    static let itemsLoaded = Notification.Name("itemsLoaded")
}
