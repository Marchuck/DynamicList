//
//  TableViewCell1.swift
//  DynamicList
//
//  Created by Łukasz Marczak on 09.04.2017.
//  Copyright © 2017 Łukasz Marczak. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {

    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
