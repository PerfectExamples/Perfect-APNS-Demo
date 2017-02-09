//
//  NewsCell.swift
//  Perfect News
//
//  Created by Ryan Collins on 2/9/17.
//  Copyright © 2017 Ryan Collins. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var notificationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ item: NewsItem) {
        
    }

}
