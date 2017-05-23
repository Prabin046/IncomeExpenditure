//
//  ViewControllerTwo.swift
//  SwipePageMenu
//
//  Created by Prabin on 4/28/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewControllerTwo: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var collectionView: UICollectionView?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    var nameArray: [String] = []
    var priceArray: [String] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var tbResult2: UITextField!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet var viewControllerTwo: UIView!
    
    var tblServices = [TblServices]()
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    internal var noOfDataInTable = Int()
    let date : String = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth/3)-15, height: (screenWidth/3)-15)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView2!.collectionViewLayout = layout
        
        loadServicesInArray()

       
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tblServices.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as! CollectionViewCellTwo
       
        let tblService1 = tblServices[indexPath.row]
        cell.Image2?.image = UIImage(named: tblService1.image)
        cell.lbName2?.text = tblService1.name
        cell.lbNumber2?.text = "Rs. " + tblService1.price
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext

        tbResult2.text = "Rs -" + priceArray[indexPath.row]
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
        newEntry.setValue(0, forKey: "isIncome")
        newEntry.setValue(date, forKey: "date")
        
        
        do{
            try context.save()
        }catch{
            print("Error...!")
        }
        
   
        
    }
    func loadServicesInArray()  {
        
        
        let request = NSFetchRequest(entityName: "TblServices")
        let predicate = NSPredicate(format: "active contains 1 AND isIncome contains 0")
        request.predicate = predicate
        
        do{
            try tblServices = moContext.executeFetchRequest(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        self.collectionView2.reloadData()
        
    }
    //Saving Data In Database For the First Time
    func InsertServicesInDatabaseForFirstTime()  {
                
        
    }


    override func viewWillAppear(animated: Bool) {
        tbResult2.text = "Rs "
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        tbResult2.text = "Rs "
    }

}
