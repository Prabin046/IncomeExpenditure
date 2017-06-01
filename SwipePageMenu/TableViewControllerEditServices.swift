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
    
       
    
    
    let moContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    //var nameArray: [String] = []
    //var priceArray: [String] = []
    var tblServices = [TblServices]()
    var tblServicesdelete:TblServices?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultValue = UserDefaults.standard
        if let name = defaultValue.string(forKey: "isIncomePanelCheck") {
            isIncomePanel = name
        }
       //loadServicesInArray()
        
        
            }
    
    func loadServicesInArray()  {
        //print(isIncomePanel)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TblServices")
        
        let predicate = NSPredicate(format: "active contains 1 AND isIncome contains %@",isIncomePanel )
        request.predicate = predicate
        
        do{
            try tblServices = moContext.fetch(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        
        
       self.tableView.reloadData()
    
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellEditServices
        let tblService1 = tblServices[indexPath.row]
        cell.lbName?.text = tblService1.name
        cell.lbPrice.text = tblService1.price
        cell.cellImage.image = UIImage(named: tblService1.image)
        //Load Manual Image
        if (cell.cellImage.image == nil){
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(tblService1.image + ".png")
                
                cell.cellImage.image = UIImage(contentsOfFile: imageURL.path)
                
                
            }
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //let indexpath = self.tableView.indexPathForSelectedRow!
        let row = indexPath.row
        tblServicesdelete = tblServices[row]
        if editingStyle == UITableViewCellEditingStyle.delete
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
    
    
   
    
    override func viewWillAppear(_ animated: Bool) {
       loadServicesInArray()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        
        if isIncomePanel == "1"
        {
         self.navigationItem.title = "Add/Edit Income"
        }else
        {
        self.navigationItem.title = "Add/Edit Expense"
        }
        
        
        let testUIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(TableViewControllerEditServices.gotoAddServices))
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = nil
    }
    func  gotoAddServices() {
        
        performSegue(withIdentifier: "segueAddServices", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEditServices"
        {
            let v = segue.destination as! ViewControllerAddServices
            let indexpath = self.tableView.indexPathForSelectedRow!
            let row = indexpath.row
            v.tblServices = tblServices[row]
        }
    }
    
    func isIncomePanelCheckValuePass(_ data: Int){
        
        //print(isIncomePanel)
        //loadServicesInArray()
        
    }


}
