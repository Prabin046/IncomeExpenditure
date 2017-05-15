//
//  TableViewControllerEditServices.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/10/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class TableViewControllerEditServices: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
       
    
    
     
    var nameArray: [String] = []
    var priceArray: [String] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        do{
            let request = NSFetchRequest(entityName: "TblServices")
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject]{
                    
                    
                    let name  = String(item.valueForKey("name")!)
                    let price = String(item.valueForKey("price")!)
                    
                    
                    nameArray.append(name)
                    priceArray.append(price)
        }
            }
        }catch{
            print("Error...!")
        }
        
            }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCellEditServices
        cell.lbName.text = nameArray[indexPath.row]
        cell.lbPrice.text = priceArray[indexPath.row]
        return cell
    }
   
    
    override func viewWillAppear(animated: Bool) {
       
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title = "Add/Edit Services"
    }

    
   
}
