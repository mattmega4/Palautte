//
//  General+Extensions.swift
//  Palautte
//
//  Created by Matthew Singleton on 2/3/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  func createRoundView() {
    
    layer.cornerRadius = frame.size.width/2
    clipsToBounds = true
    
  }
}
