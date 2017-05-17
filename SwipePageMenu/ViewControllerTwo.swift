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

    var nameArray: [String] = []
    var priceArray: [String] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var tbResult2: UITextField!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet var viewControllerTwo: UIView!
    
    internal var noOfDataInTable = Int()
    let date : String = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)

    
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
                    
                    
                    
                    //lbIncome.text = String(name!)
                    //lbExpense.text = String(price!)
                    // print(name!, price!)
                    
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as! CollectionViewCellTwo
       
        cell.Image2?.image = UIImage(named: nameArray[indexPath.row])
        cell.lbName2?.text = self.nameArray[indexPath.row]
        cell.lbNumber2?.text = "Rs. " + self.priceArray[indexPath.row]
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
    

    override func viewWillAppear(animated: Bool) {
        tbResult2.text = "Rs "
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        tbResult2.text = "Rs "
    }

}
