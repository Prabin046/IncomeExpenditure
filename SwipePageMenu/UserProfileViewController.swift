//
//  UserProfileViewController.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/29/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData

class UserProfileViewController: UIViewController {

    @IBOutlet weak var imageViewUser: UIImageView!
    
    @IBOutlet weak var lbUserEmail: UILabel!
    @IBOutlet weak var lbUserName: UILabel!
    
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var lbExpense: UILabel!
    @IBOutlet weak var lbIncome: UILabel!
    
    var nameArray = [String]()
    var priceArray = [String]()
    var dateArray = [String]()
    var isIncomeArray = [String]()
    
    var tempIncome = 0
    var tempExpense = 0
    
    let date : String = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbUserName.text = "Prabin Kumar Pariyar"
        lbUserEmail.text = "prabin_kumar@yahoo.com"
        let appDele : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDele.managedObjectContext
        
        
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
            let results = try context.fetch(request)
            var i = 0
            if results.count > 0 {
                for item in results as! [NSManagedObject]{
                    
                    if (String(describing: item.value(forKey: "date")!) == date)
                    {
                        let name  = String(describing: item.value(forKey: "name")!)
                        let price = String(describing: item.value(forKey: "price")!)
                        let date = String(describing: item.value(forKey: "date")!)
                        let isIncome = String(describing: item.value(forKey: "isIncome")!)
                        
                        nameArray.append(name)
                        priceArray.append(price)
                        dateArray.append(date)
                        isIncomeArray.append(isIncome)
                        i = i + 1
                        
                    }
                    
                    //lbIncome.text = String(name!)
                    //lbExpense.text = String(price!)
                    // print(name!, price!)
                    
                }
            }
        }catch{
            print("Error...!")
        }
   
        for i in 0..<isIncomeArray.count {
            if (isIncomeArray[i] == "1"){
                tempIncome = tempIncome + Int(priceArray[i])!
            }else{
                tempExpense = tempExpense + Int(priceArray[i])!
            }
            
        }

        lbIncome.text = String(tempIncome)
        lbExpense.text = String(tempExpense)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Profile Info"
        self.navigationItem.hidesBackButton = false
        
        self.imageViewUser.layer.cornerRadius = self.imageViewUser.frame.width/2
        self.imageViewUser.clipsToBounds = true
        
        self.btnLogOut.layer.cornerRadius = 15
        self.btnLogOut.clipsToBounds = true
    }
   

   
}
