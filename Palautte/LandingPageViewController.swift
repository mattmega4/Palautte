//
//  LandingPageViewController.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/2/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  

  
  @IBOutlet weak var controlsContainer: UIView!
  @IBOutlet weak var sliderContainer: UIView!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var redTextField: UITextField!
  
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var greenTextField: UITextField!
  
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var blueTextField: UITextField!
  
  //  @IBOutlet weak var sliderHolderView: SliderHolderView!
  
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
  
  
  // MARK: View Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Create Palautte"
    
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Copperplate-Bold", size: 20)!]
    
    redTextField.delegate = self
    greenTextField.delegate = self
    blueTextField.delegate = self
    
    tabBarController?.selectedIndex = 0
    

    
    redSlider.minimumTrackTintColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    greenSlider.minimumTrackTintColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    blueSlider.minimumTrackTintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    textFieldArray+=[redTextField, greenTextField, blueTextField]
    
//    for textField in textFieldArray {
//      textField.addTarget(self, action: #selector(textFieldTextChecker(textField:)), for: .editingChanged)
//    }
    

//    
//    redSlider.addTarget(self, action: #selector(redSliderAction(sender:)), for: .valueChanged)
//    greenSlider.addTarget(self, action: #selector(greenSliderAction(sender:)), for: .valueChanged)
//    blueSlider.addTarget(self, action: #selector(blueSliderAction(sender:)), for: .valueChanged)
    
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LandingPageViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
//    displayCurrentTextFieldValues()

  }
  
  
  func useSliders() {
    
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
    
    
  }
  

  

  
//  func textFieldTextChecker(textField: UITextField) {
//    
//    guard var text = textField.text else {return}
//    
//    if let value: Int = NumberFormatter().number(from: text) as Int? {
//      var newValue = Float(value)
//      let maxVal: Float = 255
//      if newValue > maxVal {
//        newValue = 255
//        textField.text = "255"
//      }
//      
//      if textField == redTextField {
//        if isBackgroundColorInFocus == true {
//          currentRedBackgroundString = String(Int(newValue))
//          currentRedBackgroundFloat = newValue
//          redSlider.setValue(newValue, animated: true)
//        } else if !isBackgroundColorInFocus {
//          currentRedForegroundString = String(Int(newValue))
//          currentRedForegroundFloat = newValue
//          redSlider.setValue(newValue, animated: true)
//        }
//      } else if textField == greenTextField {
//        if isBackgroundColorInFocus == true {
//          currentGreenBackgroundString = String(Int(newValue))
//          currentGreenBackgroundFloat = newValue
//          greenSlider.setValue(newValue, animated: true)
//        } else if !isBackgroundColorInFocus {
//          currentGreenForegroundString = String(Int(newValue))
//          currentGreenForegroundFloat = newValue
//          greenSlider.setValue(newValue, animated: true)
//        }
//      } else if textField == blueTextField {
//        if isBackgroundColorInFocus == true {
//          currentBlueBackgroundString = String(Int(newValue))
//          currentBlueBackgroundFloat = newValue
//          blueSlider.setValue(newValue, animated: true)
//        } else if !isBackgroundColorInFocus {
//          currentBlueForegroundString = String(Int(newValue))
//          currentBlueForegroundFloat = newValue
//          blueSlider.setValue(newValue, animated: true)
//        }
//      }
//      
//    } else {
//      if textField == redTextField {
//        redTextField.text = ""
//        redSlider.setValue(0, animated: true)
//        if isBackgroundColorInFocus == true {
//          currentRedBackgroundString = "0"
//          currentRedBackgroundFloat = 0 as Float
//        } else if !isBackgroundColorInFocus {
//          currentRedForegroundString = "0"
//          currentRedForegroundFloat = 0 as Float
//        }
//      } else if textField == greenTextField {
//        greenTextField.text = ""
//        greenSlider.setValue(0, animated: true)
//        if isBackgroundColorInFocus == true {
//          currentGreenBackgroundString = "0"
//          currentGreenBackgroundFloat = 0 as Float
//        } else if !isBackgroundColorInFocus {
//          currentGreenForegroundString = "0"
//          currentGreenForegroundFloat = 0 as Float
//        }
//      } else if textField == blueTextField {
//        blueTextField.text = ""
//        blueSlider.setValue(0, animated: true)
//        if isBackgroundColorInFocus == true {
//          currentBlueBackgroundString = "0"
//          currentBlueBackgroundFloat = 0 as Float
//        } else if !isBackgroundColorInFocus {
//          currentBlueForegroundString = "0"
//          currentBlueForegroundFloat = 0 as Float
//        }
//      }
//    }
//    
//    if text.characters.count > 3 {
//      textField.text = "255"
//      if textField == redTextField {
//        if isBackgroundColorInFocus == true {
//          currentRedBackgroundString = text
//          currentRedBackgroundFloat = round(Float(text)!)
//        } else if !isBackgroundColorInFocus {
//          currentRedForegroundString = text
//          currentRedForegroundFloat = round(Float(text)!)
//        }
//      } else if textField == greenTextField {
//        if isBackgroundColorInFocus == true {
//          currentGreenBackgroundString = text
//          currentGreenBackgroundFloat = round(Float(text)!)
//        } else if !isBackgroundColorInFocus {
//          currentGreenForegroundString = text
//          currentGreenForegroundFloat = round(Float(text)!)
//        }
//      } else if textField == blueTextField {
//        if isBackgroundColorInFocus == true {
//          currentBlueBackgroundString = text
//          currentBlueBackgroundFloat = round(Float(text)!)
//        } else if !isBackgroundColorInFocus {
//          currentBlueBackgroundString = text
//          currentBlueForegroundFloat = round(Float(text)!)
//        }
//      }
//    }
//    setBackgroundAndForegroundColors()
//  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    textField.resignFirstResponder()
    return false
  }
  
  
  // MARK: IBActions
  

  
  // MARK: Target Actions
  
//  func redSliderAction(sender: UISlider) {
//    if isBackgroundColorInFocus == true {
//      currentRedBackgroundString = String(Int(sender.value))
//      redTextField.text = String(currentRedBackgroundString)
//      currentRedBackgroundFloat = round(sender.value)
//    } else if !isBackgroundColorInFocus {
//      currentRedForegroundString = String(Int(sender.value))
//      redTextField.text = String(currentRedForegroundString)
//      currentRedForegroundFloat = round(sender.value)
//    }
//    setBackgroundAndForegroundColors()
//  }
//  
//  func greenSliderAction(sender: UISlider) {
//    if isBackgroundColorInFocus == true {
//      currentGreenBackgroundString = String(Int(sender.value))
//      greenTextField.text = String(currentGreenBackgroundString)
//      currentGreenBackgroundFloat = round(sender.value)
//    } else if !isBackgroundColorInFocus {
//      currentGreenForegroundString = String(Int(sender.value))
//      greenTextField.text = String(currentGreenForegroundString)
//      currentGreenForegroundFloat = round(sender.value)
//    }
//    setBackgroundAndForegroundColors()
//  }
//  
//  func blueSliderAction(sender: UISlider) {
//    if isBackgroundColorInFocus == true {
//      currentBlueBackgroundString = String(Int(sender.value))
//      blueTextField.text = String(currentBlueBackgroundString)
//      currentBlueBackgroundFloat = round(sender.value)
//    } else if !isBackgroundColorInFocus {
//      currentBlueForegroundString = String(Int(sender.value))
//      blueTextField.text = String(currentBlueForegroundString)
//      currentBlueForegroundFloat = round(sender.value)
//    }
//    setBackgroundAndForegroundColors()
//  }
  
  
  // MARK: Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "fromLandingPageToAddPalautte" {
      
      if let controller = segue.destination as? UINavigationController {
        
        if let destinationVC = controller.topViewController as? AddPalautteViewController {
          
          destinationVC.transferredRedBackgroundColorValue = currentGreenBackgroundFloat
          destinationVC.transferredRedBackgroundColorValue = currentRedBackgroundFloat
          destinationVC.transferredGreenBackgroundColorValue = currentGreenBackgroundFloat
          destinationVC.transferredBlueBackgroundColorValue = currentBlueBackgroundFloat
          
          destinationVC.transferredRedForegroundColorValue = currentRedForegroundFloat
          destinationVC.transferredGreenForegroundColorValue = currentGreenForegroundFloat
          destinationVC.transferredBlueForegroundColorValue = currentBlueForegroundFloat
          
          
        }
      }
      
    }
    
  }
  
  
  
  
  // MARK: Keyboard Methods
  
  func keyboardWillShow(notification:NSNotification) {
    var userInfo = notification.userInfo!
    var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    var contentInset: UIEdgeInsets = self.scrollView.contentInset
    contentInset.bottom = keyboardFrame.size.height + 30
    self.scrollView.contentInset = contentInset
  }
  
  func keyboardWillHide(notification:NSNotification) {
    let contentInset:UIEdgeInsets = UIEdgeInsets.zero
    self.scrollView.contentInset = contentInset
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
