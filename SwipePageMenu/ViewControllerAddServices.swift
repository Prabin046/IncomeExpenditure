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
    
    let defaultValue = UserDefaults.standard
    
    var tblServices:TblServices?
    var tblServicesCount = [TblServices]()
    internal var noOfDataInTable = Int()
    var tempImageName = ""
    
    let moContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var imageArrayIncome: [String] = ["101","102","103","104","105","106","107","108","109","110","101","102","103","104","105","106","107","108","109","110","101","102","103","104","105","106","107","108","109","110"]
    var imageArrayExpense: [String] = ["201","202","203","204","205","206","207","208","209","210","201","202","203","204","205","206","207","208","209","210","201","202","203","204","205","206","207","208","209","210"]
    var imageArray : [String] = []
    
    
    var donebuttonCheck = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameImageArray = defaultValue.string(forKey: "isIncomePanelCheck") {
            if nameImageArray == "1"
            {
                imageArray = imageArrayIncome
            }else{
                imageArray = imageArrayExpense
            }
            //print(imageArray)
            
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewControllerAddServices.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        
        if let t = tblServices
        {
            tbName.text = t.name
            tbPrice.text = t.price
            imageViewSelected.image = UIImage(named: t.image)
            tempImageName = t.image
        }
        noOfDataInTable = CountNoOfData()
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func  gotoEditServices() {
        SaveServicesInDatabase()
        self.navigationController?.popViewController(animated: true)
                
    }
    
    func SaveServicesInDatabase()  {
        //Get the Description of the entity
        if (tblServices == nil)
        {
        let tblServicesDescription = NSEntityDescription.entity(forEntityName: "TblServices", in: moContext)
        // Creating Managed Object to be inserted into the core data
        tblServices = TblServices(entity: tblServicesDescription!, insertInto: moContext)
        }
        
        // Set the attributes
        tblServices?.id = String(noOfDataInTable)
        tblServices?.name = tbName.text!
        tblServices?.price = tbPrice.text!
        tblServices?.image = tempImageName
        if let name = defaultValue.string(forKey: "isIncomePanelCheck") {
            if name == "1"
            {
               tblServices?.isIncome = Bool(1)
            }else{
                tblServices?.isIncome = Bool(0)
            }
        
        }
        
        tblServices?.active = Bool(1)
        //Finally we issue the command to save the data
        
        
        //Save the Object
        do{
            try moContext.save()
        }catch{
            print("Error...!")
        }

    }
    
    
    
   
    
    
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! CollectionViewCellAddServices
        cell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageViewSelected.image = UIImage(named: imageArray[indexPath.row])
        tempImageName = imageArray[indexPath.row]
        //print(tempImageName)
        checkAllField()
    }
    
    
    @IBAction func nameEditingChanged(_ sender: AnyObject) {
        
        checkAllField()
    }
    
    @IBAction func priceEditingChanged(_ sender: AnyObject) {
        
        checkAllField()
    }
    
    func checkAllField() {
        if(tbPrice.text != "" && tbName.text != "" && imageViewSelected.image != nil)
        {
            let testUIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target:self, action: #selector(ViewControllerAddServices.gotoEditServices))
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
   
    
    func CountNoOfData() -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TblServices")
        
        
        do{
            try tblServicesCount = moContext.fetch(request) as! [TblServices]
        }catch{
            print("Error...!")
        }
        return tblServicesCount.count + 1
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add Services"
        self.navigationItem.hidesBackButton = false
    }

}
