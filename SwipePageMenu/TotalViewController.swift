//
//  TotalViewController.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/1/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TotalViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var nameArray = [String]()
    var priceArray = [String]()
    var dateArray = [String]()
    var isIncomeArray = [String]()
    
    
    var tempIncome = 0
    var tempExpense = 0
    let date : String = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    
    
    
    @IBOutlet weak var tableViewIncomeExpense: UITableView!
    @IBOutlet weak var lbIncomeTEst: UILabel!
    @IBOutlet weak var lbIncome: UILabel!
    @IBOutlet weak var lbExpense: UILabel!
    
   
   
    //var addResult = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // barBtnMenu.target = revealViewController()
      //  barBtnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //lbIncome.text = String(defaults.objectForKey("income"))

        //lbIncome.text = incomeCV.tbResult.text
        // Do any additional setup after loading the view.
       // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //self.navigationItem.hidesBackButton = false
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
        
        
        self.tableViewIncomeExpense.reloadData()
        
        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellResult
       
        cell.lbNameTableCell.text = nameArray[indexPath.row]
        cell.lbPriceTableCell.text = priceArray[indexPath.row]
        cell.lbSnTableCell.text = dateArray[indexPath.row]
        
        if (isIncomeArray[indexPath.row] == "1")
        {
            cell.lbSnTableCell.textColor = UIColor.black
            cell.lbNameTableCell.textColor = UIColor.black
            cell.lbPriceTableCell.textColor = UIColor.black
        }else{
            cell.lbSnTableCell.textColor = UIColor.red
            cell.lbNameTableCell.textColor = UIColor.red
            cell.lbPriceTableCell.textColor = UIColor.red
        }
        return(cell)
            }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableViewIncomeExpense.reloadData()
        //self.navigationController?.navigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title = "Income/Expense Report"
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   

}
