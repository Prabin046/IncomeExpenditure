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
    
    protocol delegateIsIncomePanel {
        func isIncomePanelCheckValuePass(_ data: Int)
    }
class ViewControllerOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, delegateLoadServicesInArray{

    
    let defaultValue = UserDefaults.standard
    
    
    
    var delegate: delegateIsIncomePanel?
    
    var isIncomePanel = 0
    
    
    
    let hasLaunchedKey = "HasLaunched"
    let defaults = UserDefaults.standard

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
    let date : String = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)

    let moContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    
    
    
    
    //let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultValue.set("1", forKey: "isIncomePanelCheck")
        let hasLaunched = defaults.bool(forKey: hasLaunchedKey)
        
        if !hasLaunched {
            //print("Hello for first Time")
            InsertServicesInDatabaseForFirstTime()
            defaults.set(true, forKey: hasLaunchedKey)
        }

        

        
        //loadServicesInArray()
        
       // self.btnResult.layer.cornerRadius = self.btnResult.frame.width/2
        //self.btnResult.clipsToBounds = true
        
        
        //Codes for Layout of HomePage
        screenSize = UIScreen.main.bounds
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
        
        var imageArrayIncome: [String] = ["101","102","103","104","105","106","107","108","109","110"]
        

        

        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        for i in 0..<name.count{
         let newEntry = NSEntityDescription.insertNewObject(forEntityName: "TblServices", into: context)
         
         newEntry.setValue(String(i + 1), forKey: "id")
         newEntry.setValue(name[i], forKey: "name")
         newEntry.setValue(numbers[i], forKey: "price")
         newEntry.setValue(imageArrayIncome[i], forKey: "image")
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
        
        var imageArrayExpense: [String] = ["201","202","203","204","205","206","207","208","209","210"]
        
        
        for i in 0..<nameExpense.count{
            let newEntry = NSEntityDescription.insertNewObject(forEntityName: "TblServices", into: context)
            
            newEntry.setValue(String(i + 1 + name.count), forKey: "id")
            newEntry.setValue(nameExpense[i], forKey: "name")
            newEntry.setValue(numbersExpense[i], forKey: "price")
            newEntry.setValue(imageArrayExpense[i], forKey: "image")
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
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TblServices")
        let predicate = NSPredicate(format: "active contains 1 AND isIncome contains 1")
        request.predicate = predicate
        
        do{
            try tblServices = moContext.fetch(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        self.collectionView1.reloadData()

        }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tblServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellOne
        let tblService1 = tblServices[indexPath.row]
        cell.Image1?.image = UIImage(named: tblService1.image)
        cell.lbName?.text = tblService1.name
        cell.lbNumber?.text = "Rs. " + tblService1.price
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Cell Click Blink Effect
        let cell1 = collectionView.cellForItem(at: indexPath) as! CollectionViewCellOne
        
        cell1.backgroundColor = UIColor.clear
        let when = DispatchTime.now() + 0.05 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            cell1.backgroundColor = UIColor.white
        }
        
        
            
        
        
        
        //Storing Data in Database
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        
        
        let tblService1 = tblServices[indexPath.row]
        // textfield animation
        
        
        tbResult.text = "Rs " + tblService1.price
        
        //tbResult.text = "Rs " + priceArray[indexPath.row]
        //COUNTING NO OF DATA IN TABLE
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
            let results = try context.fetch(request)
            noOfDataInTable = results.count + 1
            
           
        }catch{
            print("Error...!")
        }
        
        
        let newEntry = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context)
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
    
   
    
       override func viewWillDisappear(_ animated: Bool) {
        tbResult.text = "Rs "
       

    }
   
    func switchIncomeExpensePanel()  {
        if isIncomePanel == 0
        {
            isIncomePanel = 1
            defaultValue.set("0", forKey: "isIncomePanelCheck")
        }else if isIncomePanel == 1
        {
            isIncomePanel = 0
            defaultValue.set("1", forKey: "isIncomePanelCheck")
        }
       // print(isIncomePanel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEdit"{
        let destController : TableViewControllerEditServices = (self.storyboard?.instantiateViewController(withIdentifier: "TableViewControllerEditServices")) as! TableViewControllerEditServices
        self.delegate = destController
        
        
        delegate?.isIncomePanelCheckValuePass(isIncomePanel)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let testUIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target:self, action: "gotoProfile")
        self.navigationItem.leftBarButtonItem  = testUIBarButtonItem
    }
    func gotoProfile() {
        func  gotoAddServices() {
            
            performSegue(withIdentifier: "segueGotoProfile", sender: self)
            
        }
        
    }
   }
