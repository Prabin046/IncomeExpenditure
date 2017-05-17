//
//  ViewControllerAddServices.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/16/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerAddServices: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var tbName: UITextField!
    @IBOutlet weak var tbPrice: UITextField!
    @IBOutlet weak var imageViewSelected: UIImageView!
    @IBOutlet weak var collectionViewAddServices: UICollectionView!
    
    var tblServicesCount = [TblServices]()
    internal var noOfDataInTable = Int()
    var tempImageName = 0
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var imageArray: [String] = ["1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10","1","2","3","4","5","6","7","8","9","10"]
    var donebuttonCheck = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        noOfDataInTable = CountNoOfData()
        // Do any additional setup after loading the view.
    }
    func  gotoEditServices() {
        SaveServicesInDatabase()
        self.navigationController?.popViewControllerAnimated(true)
                
    }
    
    func SaveServicesInDatabase()  {
        //Get the Description of the entity
        let tblServicesDescription = NSEntityDescription.entityForName("TblServices", inManagedObjectContext: moContext)
        // Creating Managed Object to be inserted into the core data
        let tblServices = TblServices(entity: tblServicesDescription!, insertIntoManagedObjectContext: moContext)
        
        
        // Set the attributes
        tblServices.id = String(noOfDataInTable)
        print(tblServices.id)
        tblServices.name = tbName.text!
        tblServices.price = tbPrice.text!
        tblServices.image = String(tempImageName)
        tblServices.isIncome = Bool(1)
        //Finally we issue the command to save the data
        
        
        //Save the Object
        do{
            try moContext.save()
        }catch{
            print("Error...!")
        }

    }
    
    
    
    func CountNoOfData() -> Int {
        let request = NSFetchRequest(entityName: "TblServices")
        
        
        do{
            try tblServicesCount = moContext.executeFetchRequest(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        return tblServicesCount.count + 1
    }
    
    
    
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellImage", forIndexPath: indexPath) as! CollectionViewCellAddServices
        cell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        imageViewSelected.image = UIImage(named: imageArray[indexPath.row])
        tempImageName = Int(imageArray[indexPath.row])!
        checkAllField()
    }
    
    
    @IBAction func nameEditingChanged(sender: AnyObject) {
        
        checkAllField()
    }
    
    @IBAction func priceEditingChanged(sender: AnyObject) {
        
        checkAllField()
    }
    
    func checkAllField() {
        if(tbPrice.text != "" && tbName.text != "" && tempImageName != 0)
        {
            let testUIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target:self, action: #selector(ViewControllerAddServices.gotoEditServices))
            self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
            donebuttonCheck = 1
        }else{
            if(donebuttonCheck == 1)
            {
                self.navigationItem.rightBarButtonItem  = nil
                donebuttonCheck = 0
            }
        }
    }
   
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Add Services"
        self.navigationItem.hidesBackButton = false
    }

}
