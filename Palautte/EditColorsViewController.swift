//
//  EditColorsViewController.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/11/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit

class EditColorsViewController: UIViewController {
  
  
  
  let leftHiddenView = UIView()
  let centerHiddenView = UIView()
  let rightHiddenView = UIView()
  
  let redSlider = UISlider()
  let greenSlider = UISlider()
  let blueSlider = UISlider()
  
  var textFieldArray: [UITextField] = []
  var isBackgroundColorInFocus = true
  
  var currentRedBackgroundString = "255"
  var currentGreenBackgroundString = "255"
  var currentBlueBackgroundString = "255"
  
  var currentRedForegroundString = "0"
  var currentGreenForegroundString = "0"
  var currentBlueForegroundString = "0"
  
  var currentRedBackgroundFloat: Float = 255
  var currentGreenBackgroundFloat: Float = 255
  var currentBlueBackgroundFloat: Float = 255
  
  var currentRedForegroundFloat: Float = 0
  var currentGreenForegroundFloat: Float = 0
  var currentBlueForegroundFloat: Float = 0
  
  var currentRedBackgroundCGFloat: CGFloat = 255.0/255.0
  var currentGreenBackgroundCGFloat: CGFloat = 255.0/255.0
  var currentBlueBackgroundCGFloat: CGFloat = 255.0/255.0
  
  var currentRedForegroundCGFloat: CGFloat = 0.0/255.0
  var currentGreenForegroundCGFloat: CGFloat = 0.0/255.0
  var currentBlueForegroundCGFloat: CGFloat = 0.0/255.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
  
}
