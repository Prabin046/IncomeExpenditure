//
//  ViewController.swift
//  SwipePageMenu
//
//  Created by Prabin on 4/28/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import PageMenu
import Foundation

protocol delegateLoadServicesInArray {
    func loadServicesInArray()
    func switchIncomeExpensePanel()
}

protocol delegateLoadServicesInArrayExpense {
    func loadServicesInArrayExpense()
    
}

class ViewController: UIViewController, CAPSPageMenuDelegate{
    
    var delegate: delegateLoadServicesInArray?
    var delegateExpense: delegateLoadServicesInArrayExpense?
    var pageMenu : CAPSPageMenu?
    
    let defaultValue = UserDefaults.standard
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var barBtnMenu: UIBarButtonItem!
    @IBOutlet weak var barbtnResult: UIBarButtonItem!
    
 
    
    

    
          override func viewDidLoad() {
        super.viewDidLoad()
    
                   //navigationController?.navigationBar.hidden = true
               // Do any additional setup after loading the view, typically from a nib.
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        let controller1 : ViewControllerOne = (self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerOne")) as! ViewControllerOne
            self.delegate = controller1
        controller1.title = "Income"
        controllerArray.append(controller1)
        
        let controller2 : ViewControllerTwo = (self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerTwo"))as! ViewControllerTwo
             self.delegateExpense = controller2
        controller2.title = "Expense"
        controllerArray.append(controller2)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
            
            
       let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor.lightGray),
            .selectedMenuItemLabelColor (UIColor.white),
            .unselectedMenuItemLabelColor (UIColor.darkGray),
            .selectionIndicatorColor (UIColor.black)
            
        
        
        ]
 
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.myView.addSubview(pageMenu!.view)
        
        pageMenu!.delegate = self
        
        
      
        // self.presentViewController(nextVC, animated: true, completion: nil)
           }

    @IBAction func barBtnEdit(_ sender: AnyObject) {
        //let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("TableViewControllerEditServices") as! TableViewControllerEditServices
       // self.navigationController?.presentViewController(nextVC, animated: true, completion: nil)
    }
    @IBAction func barbtnResult(_ sender: AnyObject) {
        //let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("TotalViewController") as! TotalViewController
       // self.presentViewController(nextVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func willMoveToPage(_ controller: UIViewController, index: Int){
        //print(index)
        delegate?.switchIncomeExpensePanel()
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
        if let name = defaultValue.string(forKey: "isIncomePanelCheck") {
            if name == "1"{
                delegate?.loadServicesInArray()
            }
            else if name == "0"{
              delegateExpense?.loadServicesInArrayExpense()
            }
        }
    }

    
}

