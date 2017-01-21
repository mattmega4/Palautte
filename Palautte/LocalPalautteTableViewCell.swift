//
//  LocalPalautteTableViewCell.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/11/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit
import CoreData

class LocalPalautteTableViewCell: UITableViewCell {
  
  @IBOutlet weak var backgroundColorView: UIView!
  @IBOutlet weak var foregroundColorView: UIView!
  
  @IBOutlet weak var nameOfPalautte: UILabel!
  @IBOutlet weak var categoryOfPalautte: UILabel!
  
  var controller: NSFetchedResultsController<Palautte>!

  
  
  func configureCell(palautte: Palautte) {
    
    let backRed = palautte.toBackgroundColor?.redValue ?? ""
    let backGreen = palautte.toBackgroundColor?.greenValue ?? ""
    let backBlue = palautte.toBackgroundColor?.blueValue ?? ""
    
    let foreRed = palautte.toForegroundColor?.redValue ?? ""
    let foreGreen = palautte.toForegroundColor?.greenValue ?? ""
    let foreBlue = palautte.toForegroundColor?.blueValue ?? ""
    
    let almostBackRed = Float(backRed)
    let readyBackRed = almostBackRed!/255.0
    
    let almostBackGreen = Float(backGreen)
    let readyBackGreen = almostBackGreen!/255.0
    
    let almostBackBlue = Float(backBlue)
    let readyBackBlue = almostBackBlue!/255.0
    
    
    let almostForeRed = Float(foreRed)
    let readyForeRed = almostForeRed!/255.0
    
    let almostForeGreen = Float(foreGreen)
    let readyForeGreen = almostForeGreen!/255.0
    
    let almostForeBlue = Float(foreBlue)
    let readyForeBlue = almostForeBlue!/255.0
    
    backgroundColorView.backgroundColor = UIColor.init(red: CGFloat(readyBackRed), green: CGFloat(readyBackGreen), blue: CGFloat(readyBackBlue), alpha: 1.0)
    
    foregroundColorView.backgroundColor = UIColor.init(red: CGFloat(readyForeRed), green: CGFloat(readyForeGreen), blue: CGFloat(readyForeBlue), alpha: 1.0)

    nameOfPalautte.text = palautte.name
    categoryOfPalautte.text = palautte.category
    
  }
  
} 


