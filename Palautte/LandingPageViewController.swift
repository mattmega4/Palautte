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
  
  @IBOutlet weak var textLeftButton: UIButton!
  @IBOutlet weak var dividerImageViewTextAndShapeButton: UIImageView!
  @IBOutlet weak var shapeRightButton: UIButton!
  
  @IBOutlet weak var backgroundCanvas: UIView!
  
  @IBOutlet weak var foregroundShape: UIView!
  @IBOutlet weak var foregroundText: UILabel!
  
  @IBOutlet weak var backgroundColorButton: UIButton!
  @IBOutlet weak var backgroundColorButtonUnderline: UIView!
  
  @IBOutlet weak var foregroundColorButton: UIButton!
  @IBOutlet weak var foregroundolorButtonUnderline: UIView!
  
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
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Copperplate-Bold", size: 20)!]
    
    redTextField.delegate = self
    greenTextField.delegate = self
    blueTextField.delegate = self
    
    tabBarController?.selectedIndex = 0
    
    setBackgroundAndForegroundColors()
    
    // take all code starting here and eventually put into seperate file
    
    // Mark: Hidden View
    
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
    
    // end here
    
    redSlider.minimumTrackTintColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    greenSlider.minimumTrackTintColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    blueSlider.minimumTrackTintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    textFieldArray+=[redTextField, greenTextField, blueTextField]
    
    for textField in textFieldArray {
      textField.addTarget(self, action: #selector(textFieldTextChecker(textField:)), for: .editingChanged)
    }
    
    setDefaultStateForForegroundObjects()
    setDefaultStateForBackgroundAndForegroundButtons()
    
    redSlider.addTarget(self, action: #selector(redSliderAction(sender:)), for: .valueChanged)
    greenSlider.addTarget(self, action: #selector(greenSliderAction(sender:)), for: .valueChanged)
    blueSlider.addTarget(self, action: #selector(blueSliderAction(sender:)), for: .valueChanged)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LandingPageViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    displayCurrentTextFieldValues()
    textLeftButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    shapeRightButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    
    
    
  }
  
  
  // MARK: Background & Foreground Color Setter
  
  func setBackgroundAndForegroundColors() {
    
    let redBackgroundCGFloat = CGFloat(currentRedBackgroundFloat)
    currentRedBackgroundCGFloat = redBackgroundCGFloat/255.0
    
    let greenBackgroundCGFloat = CGFloat(currentGreenBackgroundFloat)
    currentGreenBackgroundCGFloat = greenBackgroundCGFloat/255.0
    
    let blueBackgroundCGFloat = CGFloat(currentBlueBackgroundFloat)
    currentBlueBackgroundCGFloat = blueBackgroundCGFloat/255.0
    
    
    let redForegroundCGFloat = CGFloat(currentRedForegroundFloat)
    currentRedForegroundCGFloat = redForegroundCGFloat/255.0
    
    let greenForegroundCGFloat = CGFloat(currentGreenForegroundFloat)
    currentGreenForegroundCGFloat = greenForegroundCGFloat/255.0
    
    let blueForegroundCGFloat = CGFloat(currentBlueForegroundFloat)
    currentBlueForegroundCGFloat = blueForegroundCGFloat/255.0
    
    
    backgroundCanvas.backgroundColor = UIColor(red: currentRedBackgroundCGFloat, green: currentGreenBackgroundCGFloat, blue: currentBlueBackgroundCGFloat, alpha: 1)
    
    foregroundText.textColor = UIColor(red: currentRedForegroundCGFloat, green: currentGreenForegroundCGFloat, blue: currentBlueForegroundCGFloat, alpha: 1)
    foregroundShape.backgroundColor = UIColor(red: currentRedForegroundCGFloat, green: currentGreenForegroundCGFloat, blue: currentBlueForegroundCGFloat, alpha: 1)
  }
  
  
  // MARK: Foreground Object Functions
  
  
  func setDefaultStateForForegroundObjects() {
    textLeftButton.setImage(UIImage.init(named: "textColor.png"), for: UIControlState())
    shapeRightButton.setImage(UIImage.init(named: "shapeWhite.png"), for: UIControlState())
    foregroundShape.isHidden = true
    foregroundText.isHidden = false
  }
  
  func activateLeftForegroundObject() {
    setDefaultStateForForegroundObjects()
  }
  
  func activateRightForegroundObject() {
    textLeftButton.setImage(UIImage.init(named: "textWhite.png"), for: UIControlState())
    shapeRightButton.setImage(UIImage.init(named: "shapeColor.png"), for: UIControlState())
    foregroundShape.isHidden = false
    foregroundText.isHidden = true
  }
  
  
  // MARK: Background & Foreground Button Switcher Functions
  
  func setDefaultStateForBackgroundAndForegroundButtons() {
    backgroundColorButton.setTitleColor(UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0), for: UIControlState())
    foregroundColorButton.setTitleColor(.white, for: UIControlState())
    backgroundColorButtonUnderline.isHidden = false
    foregroundolorButtonUnderline.isHidden = true
    backgroundColorButtonUnderline.backgroundColor = UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0)
    foregroundolorButtonUnderline.backgroundColor = .white
    isBackgroundColorInFocus = true
    displayCurrentTextFieldValues()
    displayCurrentSliderValues()
  }
  
  func turnOnLeftColorButton() {
    setDefaultStateForBackgroundAndForegroundButtons()
    displayCurrentTextFieldValues()
    displayCurrentSliderValues()
  }
  
  func turnOnRightColorButton() {
    backgroundColorButton.setTitleColor(UIColor.white, for: .normal)
    foregroundColorButton.setTitleColor(UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0), for: .normal)
    backgroundColorButtonUnderline.isHidden = true
    foregroundolorButtonUnderline.isHidden = false
    backgroundColorButtonUnderline.backgroundColor = UIColor.white
    foregroundolorButtonUnderline.backgroundColor = UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0)
    isBackgroundColorInFocus = false
    displayCurrentTextFieldValues()
    displayCurrentSliderValues()
  }
  
  
  // MARK: UISlider
  
  func displayCurrentSliderValues() {
    if isBackgroundColorInFocus == true {
      redSlider.setValue(currentRedBackgroundFloat, animated: true)
      greenSlider.setValue(currentGreenBackgroundFloat, animated: true)
      blueSlider.setValue(currentBlueBackgroundFloat, animated: true)
    } else if !isBackgroundColorInFocus {
      redSlider.setValue(currentRedForegroundFloat, animated: true)
      greenSlider.setValue(currentGreenForegroundFloat, animated: true)
      blueSlider.setValue(currentBlueForegroundFloat, animated: true)
    }
  }
  
  
  // MARK: UITextField
  
  func displayCurrentTextFieldValues() {
    if isBackgroundColorInFocus == true {
      redTextField.text = currentRedBackgroundString
      greenTextField.text = currentGreenBackgroundString
      blueTextField.text = currentBlueBackgroundString

    } else if !isBackgroundColorInFocus {
      redTextField.text = currentRedForegroundString
      greenTextField.text = currentGreenForegroundString
      blueTextField.text = currentBlueForegroundString

    }
  }
  
  
  @objc func textFieldTextChecker(textField: UITextField) {
    
    guard var text = textField.text else {return}
    
    if let value: Int = NumberFormatter().number(from: text) as! Int? {
      var newValue = Float(value)
      let maxVal: Float = 255
      if newValue > maxVal {
        newValue = 255
        textField.text = "255"
      }
      
      if textField == redTextField {
        if isBackgroundColorInFocus == true {
          currentRedBackgroundString = String(Int(newValue))
          currentRedBackgroundFloat = newValue
          redSlider.setValue(newValue, animated: true)
        } else if !isBackgroundColorInFocus {
          currentRedForegroundString = String(Int(newValue))
          currentRedForegroundFloat = newValue
          redSlider.setValue(newValue, animated: true)
        }
      } else if textField == greenTextField {
        if isBackgroundColorInFocus == true {
          currentGreenBackgroundString = String(Int(newValue))
          currentGreenBackgroundFloat = newValue
          greenSlider.setValue(newValue, animated: true)
        } else if !isBackgroundColorInFocus {
          currentGreenForegroundString = String(Int(newValue))
          currentGreenForegroundFloat = newValue
          greenSlider.setValue(newValue, animated: true)
        }
      } else if textField == blueTextField {
        if isBackgroundColorInFocus == true {
          currentBlueBackgroundString = String(Int(newValue))
          currentBlueBackgroundFloat = newValue
          blueSlider.setValue(newValue, animated: true)
        } else if !isBackgroundColorInFocus {
          currentBlueForegroundString = String(Int(newValue))
          currentBlueForegroundFloat = newValue
          blueSlider.setValue(newValue, animated: true)
        }
      }
      
    } else {
      if textField == redTextField {
        redTextField.text = ""
        redSlider.setValue(0, animated: true)
        if isBackgroundColorInFocus == true {
          currentRedBackgroundString = "0"
          currentRedBackgroundFloat = 0 as Float
        } else if !isBackgroundColorInFocus {
          currentRedForegroundString = "0"
          currentRedForegroundFloat = 0 as Float
        }
      } else if textField == greenTextField {
        greenTextField.text = ""
        greenSlider.setValue(0, animated: true)
        if isBackgroundColorInFocus == true {
          currentGreenBackgroundString = "0"
          currentGreenBackgroundFloat = 0 as Float
        } else if !isBackgroundColorInFocus {
          currentGreenForegroundString = "0"
          currentGreenForegroundFloat = 0 as Float
        }
      } else if textField == blueTextField {
        blueTextField.text = ""
        blueSlider.setValue(0, animated: true)
        if isBackgroundColorInFocus == true {
          currentBlueBackgroundString = "0"
          currentBlueBackgroundFloat = 0 as Float
        } else if !isBackgroundColorInFocus {
          currentBlueForegroundString = "0"
          currentBlueForegroundFloat = 0 as Float
        }
      }
    }
    
    if text.characters.count > 3 {
      textField.text = "255"
      if textField == redTextField {
        if isBackgroundColorInFocus == true {
          currentRedBackgroundString = text
          currentRedBackgroundFloat = round(Float(text)!)
        } else if !isBackgroundColorInFocus {
          currentRedForegroundString = text
          currentRedForegroundFloat = round(Float(text)!)
        }
      } else if textField == greenTextField {
        if isBackgroundColorInFocus == true {
          currentGreenBackgroundString = text
          currentGreenBackgroundFloat = round(Float(text)!)
        } else if !isBackgroundColorInFocus {
          currentGreenForegroundString = text
          currentGreenForegroundFloat = round(Float(text)!)
        }
      } else if textField == blueTextField {
        if isBackgroundColorInFocus == true {
          currentBlueBackgroundString = text
          currentBlueBackgroundFloat = round(Float(text)!)
        } else if !isBackgroundColorInFocus {
          currentBlueBackgroundString = text
          currentBlueForegroundFloat = round(Float(text)!)
        }
      }
    }
    setBackgroundAndForegroundColors()
  }
  
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
  
  @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "fromLandingPageToAddPalautte", sender: self)
  }
  
  @IBAction func leftTextButtonTapped(_ sender: UIButton) {
    activateLeftForegroundObject()
  }
  
  @IBAction func rightShapeButtonTapped(_ sender: UIButton) {
    activateRightForegroundObject()
  }
  
  @IBAction func backgroundColorButtonTapped(_ sender: UIButton) {
    turnOnLeftColorButton()
    displayCurrentSliderValues()
    displayCurrentTextFieldValues()
  }
  
  @IBAction func foregroundColorButtonTapped(_ sender: UIButton) {
    turnOnRightColorButton()
    displayCurrentSliderValues()
    displayCurrentTextFieldValues()
  }
  
  
  // MARK: Target Actions
  
  @objc func redSliderAction(sender: UISlider) {
    if isBackgroundColorInFocus == true {
      currentRedBackgroundString = String(Int(sender.value))
      redTextField.text = String(currentRedBackgroundString)
      currentRedBackgroundFloat = round(sender.value)
    } else if !isBackgroundColorInFocus {
      currentRedForegroundString = String(Int(sender.value))
      redTextField.text = String(currentRedForegroundString)
      currentRedForegroundFloat = round(sender.value)
    }
    setBackgroundAndForegroundColors()
  }
  
  @objc func greenSliderAction(sender: UISlider) {
    if isBackgroundColorInFocus == true {
      currentGreenBackgroundString = String(Int(sender.value))
      greenTextField.text = String(currentGreenBackgroundString)
      currentGreenBackgroundFloat = round(sender.value)
    } else if !isBackgroundColorInFocus {
      currentGreenForegroundString = String(Int(sender.value))
      greenTextField.text = String(currentGreenForegroundString)
      currentGreenForegroundFloat = round(sender.value)
    }
    setBackgroundAndForegroundColors()
  }
  
  @objc func blueSliderAction(sender: UISlider) {
    if isBackgroundColorInFocus == true {
      currentBlueBackgroundString = String(Int(sender.value))
      blueTextField.text = String(currentBlueBackgroundString)
      currentBlueBackgroundFloat = round(sender.value)
    } else if !isBackgroundColorInFocus {
      currentBlueForegroundString = String(Int(sender.value))
      blueTextField.text = String(currentBlueForegroundString)
      currentBlueForegroundFloat = round(sender.value)
    }
    setBackgroundAndForegroundColors()
  }
  
  
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
  
  @objc func keyboardWillShow(notification:NSNotification) {
    var userInfo = notification.userInfo!
    var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    var contentInset: UIEdgeInsets = self.scrollView.contentInset
    contentInset.bottom = keyboardFrame.size.height + 30
    self.scrollView.contentInset = contentInset
  }
  
  @objc func keyboardWillHide(notification:NSNotification) {
    let contentInset:UIEdgeInsets = UIEdgeInsets.zero
    self.scrollView.contentInset = contentInset
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
