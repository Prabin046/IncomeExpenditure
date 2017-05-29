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

class ViewControllerTwo: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, delegateLoadServicesInArrayExpense{

    
    var collectionView: UICollectionView?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    var nameArray: [String] = []
    var priceArray: [String] = []
    let defaults = UserDefaults.standard
    @IBOutlet weak var tbResult2: UITextField!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet var viewControllerTwo: UIView!
    
    var tblServices = [TblServices]()
    let moContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    internal var noOfDataInTable = Int()
    let date : String = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth/3)-15, height: (screenWidth/3)-15)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView2!.collectionViewLayout = layout
        
        loadServicesInArrayExpense()

       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tblServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCellTwo
       
        let tblService1 = tblServices[indexPath.row]
        cell.Image2?.image = UIImage(named: tblService1.image)
        cell.lbName2?.text = tblService1.name
        cell.lbNumber2?.text = "Rs. " + tblService1.price
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Cell Click Blink Effect
        let cell1 = collectionView.cellForItem(at: indexPath) as! CollectionViewCellTwo
        
        cell1.backgroundColor = UIColor.clear
        let when = DispatchTime.now() + 0.05 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            cell1.backgroundColor = UIColor.white
        }

        
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext

        let tblService1 = tblServices[indexPath.row]
        tbResult2.text = "Rs -" + tblService1.price
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
        newEntry.setValue(0, forKey: "isIncome")
        newEntry.setValue(date, forKey: "date")
        
        
        do{
            try context.save()
        }catch{
            print("Error...!")
        }
        
   
        
    }
    func loadServicesInArrayExpense()  {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TblServices")
        let predicate = NSPredicate(format: "active contains 1 AND isIncome contains 0")
        request.predicate = predicate
        
        do{
            try tblServices = moContext.fetch(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        self.collectionView2.reloadData()
        
    }
    //Saving Data In Database For the First Time
    func InsertServicesInDatabaseForFirstTime()  {
                
        
    }


    override func viewWillAppear(_ animated: Bool) {
        tbResult2.text = "Rs "
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        tbResult2.text = "Rs "
    }

}
