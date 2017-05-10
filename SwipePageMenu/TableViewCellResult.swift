//
//  TableViewCellResult.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/5/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit

class TableViewCellResult: UITableViewCell {
    
    
   
    @IBOutlet weak var lbSnTableCell: UILabel!
    @IBOutlet weak var lbNameTableCell: UILabel!

    @IBOutlet weak var lbPriceTableCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
