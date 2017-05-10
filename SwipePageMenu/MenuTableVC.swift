//
//  MenuTableVC.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/2/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import Foundation
class MenuTAbleVC: UITableViewController {
    var TableArray = [String]()
    override func viewDidLoad() {
        TableArray = ["Home", "Result", "Setting"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
    }
    
    
    
    
}
