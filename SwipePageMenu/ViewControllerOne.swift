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
    

class ViewControllerOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, delegateLoadServicesInArray{

    
    let hasLaunchedKey = "HasLaunched"
    let defaults = NSUserDefaults.standardUserDefaults()

    var collectionView: UICollectionView?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var tblServices = [TblServices]()
    var nameArray: [String] = []
    var priceArray: [String] = []
    var imageArray: [String] = []
    @IBOutlet weak var tbResult: UITextField!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet var viewControllerOne: UIView!
    internal var totaladd = Int()
    internal var noOfDataInTable = Int()
    let date : String = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)

    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    
    
    //let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hasLaunched = defaults.boolForKey(hasLaunchedKey)
        
        if !hasLaunched {
            //print("Hello for first Time")
            InsertServicesInDatabaseForFirstTime()
            defaults.setBool(true, forKey: hasLaunchedKey)
        }

        

        
        //loadServicesInArray()
        
       // self.btnResult.layer.cornerRadius = self.btnResult.frame.width/2
        //self.btnResult.clipsToBounds = true
        
        
        //Codes for Layout of HomePage
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth/3)-15, height: (screenWidth/3)-15)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView1!.collectionViewLayout = layout
    
    }
    
    
    
    
    //Saving Data In Database For the First Time
    func InsertServicesInDatabaseForFirstTime()  {
        
        // Saving Income
        let name = ["कपाल काटेको","बच्चाको कपाल काटेको (१० बर्ष मुनिको )","दार्ही काटेको","सेम्पु गरेको","हेयर डराई गरेको","कपाल कालो गरेको","कपाल रातो गरेको","फेसियल गरेको","फेसवास गरेको","फचे ब्लीच गरेको"]
        let numbers = ["100", "70", "60","100","100", "350", "450","800","250", "450"]
        

        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        for i in 0..<name.count{
         let newEntry = NSEntityDescription.insertNewObjectForEntityForName("TblServices", inManagedObjectContext: context)
         
         newEntry.setValue(String(i + 1), forKey: "id")
         newEntry.setValue(name[i], forKey: "name")
         newEntry.setValue(numbers[i], forKey: "price")
         newEntry.setValue(String(i + 1), forKey: "image")
         newEntry.setValue(1, forKey: "isIncome")
         newEntry.setValue(1, forKey: "active")
        
            do{
         try context.save()
         }catch{
         print("Error...!")
         }
         }
        
        
        // Saving Expense
        let nameExpense = ["Blade Kineko","Khana Khayeko","Sicssor Kineko","Laptop Kineko","Salary Diyeko","House Rent","Cloth Kineko","Chair Kineko","Drinking Water","Carpet"]
        let numbersExpense = ["10", "70", "60","100","100", "350", "450","800","250", "450"]
        
        
        
        
        for i in 0..<nameExpense.count{
            let newEntry = NSEntityDescription.insertNewObjectForEntityForName("TblServices", inManagedObjectContext: context)
            
            newEntry.setValue(String(i + 1 + name.count), forKey: "id")
            newEntry.setValue(nameExpense[i], forKey: "name")
            newEntry.setValue(numbersExpense[i], forKey: "price")
            newEntry.setValue(String(i + 1), forKey: "image")
            newEntry.setValue(0, forKey: "isIncome")
            newEntry.setValue(1, forKey: "active")
            
            do{
                try context.save()
            }catch{
                print("Error...!")
            }
        }


    }
    func loadServicesInArray()  {
        
        
        let request = NSFetchRequest(entityName: "TblServices")
        let predicate = NSPredicate(format: "active contains 1 AND isIncome contains 1")
        request.predicate = predicate
        
        do{
            try tblServices = moContext.executeFetchRequest(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        self.collectionView1.reloadData()

        }
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tblServices.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCellOne
        let tblService1 = tblServices[indexPath.row]
        cell.Image1?.image = UIImage(named: tblService1.image)
        cell.lbName?.text = tblService1.name
        cell.lbNumber?.text = "Rs. " + tblService1.price
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //Storing Data in Database
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        
        let tblService1 = tblServices[indexPath.row]
        
        tbResult.text = "Rs " + tblService1.price
        
        //tbResult.text = "Rs " + priceArray[indexPath.row]
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
        
        
        newEntry.setValue(tblService1.name, forKey: "name")
        
        newEntry.setValue(Float(tblService1.price), forKey: "price")
        newEntry.setValue(1, forKey: "isIncome")
        newEntry.setValue(date, forKey: "date")
        
        
        do{
            try context.save()
        }catch{
            print("Error...!")
        }
        
    }
        
   
    
       override func viewWillDisappear(animated: Bool) {
        tbResult.text = "Rs "
    }
   
}
