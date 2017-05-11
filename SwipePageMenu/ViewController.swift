//
//  ViewController.swift
//  SwipePageMenu
//
//  Created by Prabin on 4/28/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import PageMenu


class ViewController: UIViewController, CAPSPageMenuDelegate{
    
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var barBtnMenu: UIBarButtonItem!
    @IBOutlet weak var barbtnResult: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        barBtnMenu.target = revealViewController()
        barBtnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        

        // Do any additional setup after loading the view, typically from a nib.
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        var controller1 : UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("ViewControllerOne"))!
        controller1.title = "First Page"
        controllerArray.append(controller1)
        
        var controller2 : UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("ViewControllerTwo"))!

        controller2.title = "Second Page"
        controllerArray.append(controller2)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
       var parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
 
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.delegate = self
        
        
        func willMoveToPage(controller: UIViewController, index: Int){}
        
        func didMoveToPage(controller: UIViewController, index: Int){}
        
        
        
        barBtnMenu.target = revealViewController()
        barBtnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("TotalViewController") as! TotalViewController
        // self.presentViewController(nextVC, animated: true, completion: nil)
           }

    @IBAction func barBtnEdit(sender: AnyObject) {
        //let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("TableViewControllerEditServices") as! TableViewControllerEditServices
       // self.navigationController?.presentViewController(nextVC, animated: true, completion: nil)
    }
    @IBAction func barbtnResult(sender: AnyObject) {
        //let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("TotalViewController") as! TotalViewController
       // self.presentViewController(nextVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
