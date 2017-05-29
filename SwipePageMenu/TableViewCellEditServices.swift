//
//  TableViewCellEditServices.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/10/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit

class TableViewCellEditServices: UITableViewCell {

    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellImage.layer.cornerRadius = 10
        cellImage.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
