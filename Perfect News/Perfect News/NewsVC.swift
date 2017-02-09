//
//  FirstViewController.swift
//  Perfect News
//
//  Created by Ryan Collins on 2/3/17.
//  Copyright © 2017 Ryan Collins. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        NotificationCenter.default.addObserver(self, selector: #selector(onNewsItemsLoaded), name: .itemsLoaded, object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onNewsItemsLoaded() {
        tableView.reloadData()
    }
    
    func notify(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = DataService.instance.loadedNews[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsCell {
            cell.configureCell(item)
            return cell
        } else {
            let cell = NewsCell()
            cell.configureCell(item)
            return cell
        }
    }
}

