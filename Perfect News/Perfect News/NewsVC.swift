//
//  FirstViewController.swift
//  Perfect News
//
//  Created by Ryan Collins on 2/3/17.
//  Copyright © 2017 Ryan Collins. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(tempTokenComplete), name: .addSuccessful, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tempTokenFailed), name: .addFailure, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tempTokenComplete() {
        print("Token Complete")
    }
    
    func tempTokenFailed() {
        print("Token Failure")
    }
}

