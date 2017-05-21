//
//  TblServices.swift
//  SwipePageMenu
//
//  Created by Prabin on 5/17/17.
//  Copyright © 2017 Prabin. All rights reserved.
//

import UIKit
import CoreData

class TblServices: NSManagedObject {
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var price:String
    @NSManaged var image: String
    @NSManaged var isIncome: Bool
    @NSManaged var active: Bool
    
}