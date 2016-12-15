//
//  LocalPalautteTableViewCell.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/11/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit

class LocalPalautteTableViewCell: UITableViewCell {
  
  @IBOutlet weak var backgroundColorView: UIView!
  @IBOutlet weak var foregroundColorView: UIView!
  
  @IBOutlet weak var nameOfPalautte: UILabel!
  @IBOutlet weak var categoryOfPalautte: UILabel!
  
  
  func configureCell(palautte: Palautte) {
    
    
    backgroundColorView.backgroundColor = .blue //
    foregroundColorView.backgroundColor = .red //
    nameOfPalautte.text = palautte.name
    categoryOfPalautte.text = palautte.category
    
  }
  
}
