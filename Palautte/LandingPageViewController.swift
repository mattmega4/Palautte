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
  
  @IBOutlet weak var demoButton: UIBarButtonItem!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var firstButtonContainer: UIView!
  @IBOutlet weak var secondButtonContainer: UIView!
  @IBOutlet weak var thirdButtonContainer: UIView!
  @IBOutlet weak var fourthButtonContainer: UIView!
  @IBOutlet weak var fifthButtonContainer: UIView!
  
  @IBOutlet weak var firstIndicatorView: UIView!
  @IBOutlet weak var secondIndicatorView: UIView!
  @IBOutlet weak var thirdIndicatorView: UIView!
  @IBOutlet weak var fourthIndicatorView: UIView!
  @IBOutlet weak var fifthIndicatorView: UIView!
  
  @IBOutlet weak var firstColorButton: UIButton!
  @IBOutlet weak var secondColorButton: UIButton!
  @IBOutlet weak var thirdColorButton: UIButton!
  @IBOutlet weak var fourthColorButton: UIButton!
  @IBOutlet weak var fifthColorButton: UIButton!
  
  @IBOutlet weak var slidersButton: UIButton!
  @IBOutlet weak var wheelButton: UIButton!
  
  @IBOutlet weak var sliderButtonUnderlineView: UIView!
  @IBOutlet weak var wheelButtonUnderlineView: UIView!
  
  @IBOutlet weak var controlsContainer: UIView!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var redTextField: UITextField!
  
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var greenTextField: UITextField!
  
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var blueTextField: UITextField!
  
  @IBOutlet weak var sliderOrWheelContainerView: UIView!

  let redSlider = UISlider()
  let greenSlider = UISlider()
  let blueSlider = UISlider()
  
  var textFieldArray: [UITextField] = []
  var indicatorViewArray: [UIView] = []
  
  var firstColorIsActive: Bool?
  var secondColorIsActive: Bool?
  var thirdColorIsActive: Bool?
  var fourthColorIsActive: Bool?
  var fifthColorIsActive: Bool?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBarController?.selectedIndex = 0
    
    redTextField.delegate = self
    greenTextField.delegate = self
    blueTextField.delegate = self
    
    setNavBar()
    populateArrayAndAddTargets()

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LandingPageViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    // temp
    useSliders()
    // temp
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
//    displayCurrentTextFieldValues()

  }
  
  
  // MARK: Nav Bar & View Design
  
  func setNavBar() {
    
    title = "Create Palautte"
    UINavigationBar.appearance().barTintColor = UIColor(red: 50.0/255.0, green: 60.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Copperplate-Bold", size: 20)!]
    
  }
  
  func turnIndicatorViewsRound() {
    
    indicatorViewArray+=[firstIndicatorView, secondIndicatorView, thirdIndicatorView, fourthIndicatorView, fifthIndicatorView]
    
    for views in indicatorViewArray {
      views.backgroundColor = .white
      views.createRoundView()
    }
    
  }
  
  
  // MARK: Arrays and Targets
  
  func populateArrayAndAddTargets() {
    
    textFieldArray+=[redTextField, greenTextField, blueTextField]

    //    for textField in textFieldArray {
    //      textField.addTarget(self, action: #selector(textFieldTextChecker(textField:)), for: .editingChanged)
    //    }

    //    redSlider.addTarget(self, action: #selector(redSliderAction(sender:)), for: .valueChanged)
    //    greenSlider.addTarget(self, action: #selector(greenSliderAction(sender:)), for: .valueChanged)
    //    blueSlider.addTarget(self, action: #selector(blueSliderAction(sender:)), for: .valueChanged)
    
  }
  

  // MARK: Color Button Functions
  
  func setColorBool(button: UIButton) {
    
    if button == firstColorButton {
      
      firstColorIsActive = true
      secondColorIsActive = false
      thirdColorIsActive = false
      fourthColorIsActive = false
      fifthColorIsActive = false
      
    } else if button == secondColorButton {
      
      firstColorIsActive = false
      secondColorIsActive = true
      thirdColorIsActive = false
      fourthColorIsActive = false
      fifthColorIsActive = false
      
    } else if button == thirdColorButton {
      
      firstColorIsActive = false
      secondColorIsActive = false
      thirdColorIsActive = true
      fourthColorIsActive = false
      fifthColorIsActive = false
      
    } else if button == fourthColorButton {
      
      firstColorIsActive = false
      secondColorIsActive = false
      thirdColorIsActive = false
      fourthColorIsActive = true
      fifthColorIsActive = false
      
    } else if button == fifthColorButton {
      
      firstColorIsActive = false
      secondColorIsActive = false
      thirdColorIsActive = false
      fourthColorIsActive = false
      fifthColorIsActive = true
      
    }
    
    // run check function
    
  }
  
  
  func doStuff() {
    
    
    
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
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    
//    if segue.identifier == "fromLandingPageToAddPalautte" {
//      
//      if let controller = segue.destination as? UINavigationController {
//        
//        if let destinationVC = controller.topViewController as? AddPalautteViewController {
//          
//          
//          
//          
//        }
//      }
//      
//    }
//    
//  }
  
  
  
  
  
  
  
  
  
  // MARK: Slider View
  
  func useSliders() {
    
    let leftHiddenView = UIView()
    let centerHiddenView = UIView()
    let rightHiddenView = UIView()
    
    redSlider.minimumTrackTintColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    greenSlider.minimumTrackTintColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    blueSlider.minimumTrackTintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    let hiddenViews = [leftHiddenView, centerHiddenView, rightHiddenView]
    var allHiddenViewConstraints: [NSLayoutConstraint] = []
    
    for views in hiddenViews {
      
      sliderOrWheelContainerView.addSubview(views)
      views.backgroundColor = .clear
      views.translatesAutoresizingMaskIntoConstraints = false
      
      let hiddenViewWidthConstraint = views.widthAnchor.constraint(equalToConstant: 35)
      let hiddenViewHeightConstraint = views.heightAnchor.constraint(equalToConstant: 5)
      
      NSLayoutConstraint.activate([hiddenViewWidthConstraint, hiddenViewHeightConstraint])
      
    }
    
    let leftViewVerticalCenterConstraint = leftHiddenView.centerYAnchor.constraint(equalTo: centerHiddenView.centerYAnchor, constant: 0)
    let leftViewTrailingConstraint = leftHiddenView.trailingAnchor.constraint(equalTo: centerHiddenView.leadingAnchor, constant: -60)
    
    let centerViewHorizontalConstraint = centerHiddenView.centerXAnchor.constraint(equalTo: sliderOrWheelContainerView.centerXAnchor)
    let centerViewTopConstraint = centerHiddenView.topAnchor.constraint(equalTo: sliderOrWheelContainerView.topAnchor, constant: 50)
    
    let rightViewVerticalCenterConstraint = rightHiddenView.centerYAnchor.constraint(equalTo: centerHiddenView.centerYAnchor, constant: 0)
    let rightViewTrailingConstraint = rightHiddenView.leadingAnchor.constraint(equalTo: centerHiddenView.trailingAnchor, constant: 60)
    
    allHiddenViewConstraints+=[leftViewVerticalCenterConstraint,
                               leftViewTrailingConstraint,
                               centerViewHorizontalConstraint,
                               centerViewTopConstraint,
                               rightViewVerticalCenterConstraint,
                               rightViewTrailingConstraint]
    
    NSLayoutConstraint.activate(allHiddenViewConstraints)
    
    let colorSliders = [redSlider, greenSlider, blueSlider]
    
    var constraints: [NSLayoutConstraint] = []
    
    for slider in colorSliders {
      slider.translatesAutoresizingMaskIntoConstraints = false
      sliderOrWheelContainerView.addSubview(slider)
      slider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
      slider.minimumValue = 0
      slider.maximumValue = 255
      slider.isEnabled = true
      slider.isUserInteractionEnabled = true
      constraints.append(slider.widthAnchor.constraint(equalTo: sliderOrWheelContainerView.heightAnchor))
      constraints.append(slider.centerYAnchor.constraint(equalTo: sliderOrWheelContainerView.centerYAnchor))
      
    }
    constraints.append(redSlider.centerXAnchor.constraint(equalTo: leftHiddenView.centerXAnchor))
    constraints.append(greenSlider.centerXAnchor.constraint(equalTo: sliderOrWheelContainerView.centerXAnchor))
    constraints.append(blueSlider.centerXAnchor.constraint(equalTo: rightHiddenView.centerXAnchor))
    
    NSLayoutConstraint.activate(constraints)
    
  }

  
  // MARK: Keyboard Methods
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    textField.resignFirstResponder()
    return false
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
