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


class TableViewControllerEditServices: UIViewController, UITableViewDelegate, UITableViewDataSource, delegateIsIncomePanel{

    
    var isIncomePanel = "1"
    
    @IBOutlet weak var tableView: UITableView!
    
       
    
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //var nameArray: [String] = []
    //var priceArray: [String] = []
    var tblServices = [TblServices]()
    var tblServicesdelete:TblServices?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultValue = NSUserDefaults.standardUserDefaults()
        if let name = defaultValue.stringForKey("isIncomePanelCheck") {
            isIncomePanel = name
        }
       //loadServicesInArray()
        
        
            }
    
    func loadServicesInArray()  {
        //print(isIncomePanel)
        let request = NSFetchRequest(entityName: "TblServices")
        
        let predicate = NSPredicate(format: "active contains 1 AND isIncome contains %@",isIncomePanel )
        request.predicate = predicate
        
        do{
            try tblServices = moContext.executeFetchRequest(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        
        
       self.tableView.reloadData()
    
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblServices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCellEditServices
        let tblService1 = tblServices[indexPath.row]
        cell.lbName?.text = tblService1.name
        cell.lbPrice.text = tblService1.price
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //let indexpath = self.tableView.indexPathForSelectedRow!
        let row = indexPath.row
        tblServicesdelete = tblServices[row]
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            
            
            // Set the attributes
            tblServicesdelete?.active = Bool(0)
            //Finally we issue the command to save the data
            
            
            //Save the Object
            do{
                try moContext.save()
                loadServicesInArray()
            }catch{
                print("Error...!")
            }
            
            
        }
    }
    
    /*
     
     
     */
    
    
   
    
    override func viewWillAppear(animated: Bool) {
       loadServicesInArray()
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.hidesBackButton = false
        
        if isIncomePanel == "1"
        {
         self.navigationItem.title = "Add/Edit Income"
        }else
        {
        self.navigationItem.title = "Add/Edit Expense"
        }
        
        
        let testUIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target:self, action: #selector(TableViewControllerEditServices.gotoAddServices))
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = nil
    }
    func  gotoAddServices() {
        
        performSegueWithIdentifier("segueAddServices", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueEditServices"
        {
            let v = segue.destinationViewController as! ViewControllerAddServices
            let indexpath = self.tableView.indexPathForSelectedRow!
            let row = indexpath.row
            v.tblServices = tblServices[row]
        }
    }
    
    func isIncomePanelCheckValuePass(data: Int){
        
        //print(isIncomePanel)
        //loadServicesInArray()
        
    }


}
