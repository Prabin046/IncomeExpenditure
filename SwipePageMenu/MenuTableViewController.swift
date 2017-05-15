//
//  MenuTableViewController.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/11/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewMenu: UITableView!
    var menuItemArray:Array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
         menuItemArray = ["Home", "Result", "Edit"]

        }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.lbMenuItem.text = menuItemArray[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         let revealViewController:SWRevealViewController = self.revealViewController()
         
         let cell:MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuTableViewCell
        
        if cell.lbMenuItem.text == "Home"
         {
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            
         }
        
        
        if cell.lbMenuItem.text == "Result"
        {/*
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewControllerWithIdentifier("TotalViewController") as! TotalViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
 */
        }
        
        if cell.lbMenuItem.text == "Edit"
        {
            /*
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewControllerWithIdentifier("TableViewControllerEditServices") as! TableViewControllerEditServices
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
 */
            
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
