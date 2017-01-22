//
//  EditColorsViewController.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/11/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit

class EditColorsViewController: UIViewController {
  
  @IBOutlet weak var topButton: UIButton!
  @IBOutlet weak var backgroundContainer: UIView!
  @IBOutlet weak var foregroundContainer: UIView!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var textFieldContainer: UIView!
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var redTextField: UITextField!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var greenTextField: UITextField!
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var blueTextField: UITextField!
  @IBOutlet weak var sliderContainer: SliderHolderView!
  @IBOutlet weak var bottomButton: UIButton!
  
  let leftHiddenView = UIView()
  let centerHiddenView = UIView()
  let rightHiddenView = UIView()
  
  let redSlider = UISlider()
  let greenSlider = UISlider()
  let blueSlider = UISlider()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ////
    
    let hiddenViews = [leftHiddenView, centerHiddenView, rightHiddenView]
    var allHiddenViewConstraints: [NSLayoutConstraint] = []
    
    for views in hiddenViews {
      
      sliderContainer.addSubview(views)
      views.backgroundColor = .clear
      views.translatesAutoresizingMaskIntoConstraints = false
      
      let hiddenViewWidthConstraint = views.widthAnchor.constraint(equalToConstant: 35)
      let hiddenViewHeightConstraint = views.heightAnchor.constraint(equalToConstant: 5)
      
      NSLayoutConstraint.activate([hiddenViewWidthConstraint, hiddenViewHeightConstraint])
      
    }
    
    let leftViewVerticalCenterConstraint = leftHiddenView.centerYAnchor.constraint(equalTo: centerHiddenView.centerYAnchor, constant: 0)
    let leftViewTrailingConstraint = leftHiddenView.trailingAnchor.constraint(equalTo: centerHiddenView.leadingAnchor, constant: -60)
    
    let centerViewHorizontalConstraint = centerHiddenView.centerXAnchor.constraint(equalTo: sliderContainer.centerXAnchor)
    let centerViewTopConstraint = centerHiddenView.topAnchor.constraint(equalTo: sliderContainer.topAnchor, constant: 50)
    
    let rightViewVerticalCenterConstraint = rightHiddenView.centerYAnchor.constraint(equalTo: centerHiddenView.centerYAnchor, constant: 0)
    let rightViewTrailingConstraint = rightHiddenView.leadingAnchor.constraint(equalTo: centerHiddenView.trailingAnchor, constant: 60)
    
    allHiddenViewConstraints+=[leftViewVerticalCenterConstraint,
                               leftViewTrailingConstraint,
                               centerViewHorizontalConstraint,
                               centerViewTopConstraint,
                               rightViewVerticalCenterConstraint,
                               rightViewTrailingConstraint]
    
    NSLayoutConstraint.activate(allHiddenViewConstraints)
    
    
    // Mark: Slider View
    
    let colorSliders = [redSlider, greenSlider, blueSlider]
    
    var constraints: [NSLayoutConstraint] = []
    
    for slider in colorSliders {
      slider.translatesAutoresizingMaskIntoConstraints = false
      sliderContainer.addSubview(slider)
      slider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
      slider.minimumValue = 0
      slider.maximumValue = 255
      slider.isEnabled = true
      slider.isUserInteractionEnabled = true
      constraints.append(slider.widthAnchor.constraint(equalTo: sliderContainer.heightAnchor))
      constraints.append(slider.centerYAnchor.constraint(equalTo: sliderContainer.centerYAnchor))
      
    }
    constraints.append(redSlider.centerXAnchor.constraint(equalTo: leftHiddenView.centerXAnchor))
    constraints.append(greenSlider.centerXAnchor.constraint(equalTo: sliderContainer.centerXAnchor))
    constraints.append(blueSlider.centerXAnchor.constraint(equalTo: rightHiddenView.centerXAnchor))
    
    NSLayoutConstraint.activate(constraints)
    
    
    ////
  }
  
  
  
}
