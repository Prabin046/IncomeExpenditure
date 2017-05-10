//
//  ViewControllerTwo.swift
//  SwipePageMenu
//
//  Created by Prabin on 4/28/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit

class ViewControllerTwo: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var tbResult2: UITextField!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet var viewControllerTwo: UIView!
    let numbers = ["100", "200", "250","300","500"]
    let imageArray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

               // Do any additional setup after loading the view.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numbers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as! CollectionViewCellTwo
        cell.Image2?.image = self.imageArray[indexPath.row]
        cell.lbNumber2?.text = self.numbers[indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        if(tbResult2.text == "Result")
        {
            tbResult2.text = "0"
        }
        
            let a = Int(tbResult2.text!)
            let b = Int(numbers[indexPath.row])!
            let sub : Int = (a! - b)
            tbResult2.text = String(sub)
             defaults.setObject(tbResult2.text, forKey: "expense")
            
        
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
