//
//  NewsItem.swift
//  Perfect News
//
//  Created by Ryan Collins on 2/8/17.
//  Copyright © 2017 Ryan Collins. All rights reserved.
//

import Foundation

class NewsItem {
    
    private var _title: String
    private var _description: String
    private var _imageURL: URL?
    
    var title: String {
        get {
            return _title
        }
    }
    
    var description: String {
        get {
            return _description
        }
    }
    
    var imageURL: URL? {
        get {
            return _imageURL
        }
    }
    
    init(title: String, description: String, imageURL: URL?) {
        _title = title
        _description = description
        _imageURL = imageURL
    }
    
}
