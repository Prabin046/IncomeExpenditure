	//
//  ViewControllerOne.swift
//  SwipePageMenu
//
//  Created by Prabin on 4/28/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewControllerOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var nameArray: [String] = []
    var priceArray: [String] = []
    var imageArray: [String] = []
    @IBOutlet weak var tbResult: UITextField!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet var viewControllerOne: UIView!
    internal var totaladd = Int()
    internal var noOfDataInTable = Int()
    let date : String = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)

    
       let name = ["कपाल काटेको",
                "बच्चाको कपाल काटेको (१० बर्ष मुनिको )",
                "दार्ही काटेको",
                "सेम्पु गरेको",
                "हेयर डराई गरेको",
                "कपाल कालो गरेको",
                "कपाल रातो गरेको",
                "फेसियल गरेको",
                "फेसवास गरेको",
                "फचे ब्लीच गरेको"
               ]
    let numbers = ["100", "70", "60","100","100", "350", "450","800","250", "450"]
    
   
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //navigationController?.navigationBar.hidden = true
        

        
        
       // self.btnResult.layer.cornerRadius = self.btnResult.frame.width/2
        //self.btnResult.clipsToBounds = true
    
    }
    //Saving Data In Database For the First Time
    func InsertServicesInDatabaseForFirstTime()  {
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        for i in 0..<name.count{
         let newEntry = NSEntityDescription.insertNewObjectForEntityForName("TblServices", inManagedObjectContext: context)
         
         newEntry.setValue(String(i + 1), forKey: "id")
         newEntry.setValue(name[i], forKey: "name")
         newEntry.setValue(numbers[i], forKey: "price")
         newEntry.setValue(String(i + 1), forKey: "image")
        
            do{
         try context.save()
         }catch{
         print("Error...!")
         }
         }
        

    }
    func loadServicesInArray()  {
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
                do{
            let request = NSFetchRequest(entityName: "TblServices")
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject]{
                    
                    
                    let name  = String(item.valueForKey("name")!)
                    let price = String(item.valueForKey("price")!)
                    let image = String(item.valueForKey("image")!)
                    
                    nameArray.append(name)
                    priceArray.append(price)
                    imageArray.append(image)
                    
                    
                    
                }
            }
        }catch{
            print("Error...!")
        }
        

    }
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCellOne
        //cell.Image1?.image = self.imageArray[indexPath.row]
        cell.Image1?.image = UIImage(named: imageArray[indexPath.row])
        cell.lbName?.text = self.nameArray[indexPath.row]
        cell.lbNumber?.text = "Rs. " + self.priceArray[indexPath.row]
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //Storing Data in Database
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        
        
        
        tbResult.text = "Rs " + priceArray[indexPath.row]
        //COUNTING NO OF DATA IN TABLE
        do{
            let request = NSFetchRequest(entityName: "Entity")
            let results = try context.executeFetchRequest(request)
            noOfDataInTable = results.count + 1
            
           
        }catch{
            print("Error...!")
        }
        
        
        let newEntry = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: context)
        newEntry.setValue(noOfDataInTable, forKey: "id")
        
        
        newEntry.setValue(nameArray[indexPath.row], forKey: "name")
        
        newEntry.setValue(Float(priceArray[indexPath.row]), forKey: "price")
        newEntry.setValue(1, forKey: "isIncome")
        newEntry.setValue(date, forKey: "date")
        
        
        do{
            try context.save()
        }catch{
            print("Error...!")
        }
        
        
    }
    
   
    override func viewDidAppear(animated: Bool) {
        loadServicesInArray()
        self.collectionView1.reloadData()
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        tbResult.text = "Rs "
    }
  
}
