//
//  EditColorsViewController.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/11/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit
import CoreData

class EditColorsViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  @IBOutlet weak var leftBarButton: UIBarButtonItem!
  @IBOutlet weak var rightbarButton: UIBarButtonItem!
  
  @IBOutlet weak var backgroundContainer: UIView!
  @IBOutlet weak var foregroundContainer: UIView!
  
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var leftButtonUnderline: UIView!
  @IBOutlet weak var rightButtonUnderline: UIView!
  
  @IBOutlet weak var textFieldContainer: UIView!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var redTextField: UITextField!
  
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var greenTextField: UITextField!
  
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var blueTextField: UITextField!
  
  @IBOutlet weak var sliderContainer: UIView!
  
  @IBOutlet weak var bottomButton: UIButton!
  
  var name: String?
  var category: String?
  
  let leftHiddenView = UIView()
  let centerHiddenView = UIView()
  let rightHiddenView = UIView()
  
  let redSlider = UISlider()
  let greenSlider = UISlider()
  let blueSlider = UISlider()
  
  var currentRedBackgroundFloat: Float?
  var currentGreenBackgroundFloat: Float?
  var currentBlueBackgroundFloat: Float?
  
  var currentRedForegroundFloat: Float?
  var currentGreenForegroundFloat: Float?
  var currentBlueForegroundFloat: Float?
  
  var palautteToEdit: Palautte?
  
  var categories = [Palautte]()
  
  var backgroundInFocus: Bool?
  
  var textFieldArray: [UITextField] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Edit Palautte"
    
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Copperplate-Bold", size: 20)!]
    
    self.redTextField.delegate = self
    self.greenTextField.delegate = self
    self.blueTextField.delegate = self
    
    textFieldArray+=[redTextField, greenTextField, blueTextField]
    
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
    
    for textField in textFieldArray {
      textField.addTarget(self, action: #selector(textFieldTextChecker(textField:)), for: .editingChanged)
    }
    
    redSlider.addTarget(self, action: #selector(redSliderAction(sender:)), for: .valueChanged)
    greenSlider.addTarget(self, action: #selector(greenSliderAction(sender:)), for: .valueChanged)
    blueSlider.addTarget(self, action: #selector(blueSliderAction(sender:)), for: .valueChanged)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditColorsViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    pullData()
    loadData()
    turnOnBackgroundButton()
    
    
  }
  
  
  // MARK: Slider and TextField Values
  
  func setDefaultDisplay() {
    
    backgroundInFocus = true
    
    leftButton.setTitleColor(UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0), for: UIControlState())
    rightButton.setTitleColor(.white, for: UIControlState())
    
    leftButtonUnderline.isHidden = false
    rightButtonUnderline.isHidden = true
    
    leftButtonUnderline.backgroundColor = UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0)
    rightButtonUnderline.backgroundColor = .white
    
    displayCurrentTextFieldValues()
    displayCurrentSliderValues()
    
  }
  
  func displayCurrentSliderValues() {
    
    if backgroundInFocus == true {
      redSlider.setValue(currentRedBackgroundFloat!, animated: true)
      greenSlider.setValue(currentGreenBackgroundFloat!, animated: true)
      blueSlider.setValue(currentBlueBackgroundFloat!, animated: true)
      
    } else if !backgroundInFocus! {
      
      redSlider.setValue(currentRedForegroundFloat!, animated: true)
      greenSlider.setValue(currentGreenForegroundFloat!, animated: true)
      blueSlider.setValue(currentBlueForegroundFloat!, animated: true)
    }
    
  }
  
  
  func displayCurrentTextFieldValues() {
    
    if backgroundInFocus == true {
      
      redTextField.text = String(Int(currentRedBackgroundFloat!))
      greenTextField.text = String(Int(currentGreenBackgroundFloat!))
      blueTextField.text = String(Int(currentBlueBackgroundFloat!))
      
    } else if backgroundInFocus == false {
      
      redTextField.text = String(Int(currentRedForegroundFloat!))
      greenTextField.text = String(Int(currentGreenForegroundFloat!))
      blueTextField.text = String(Int(currentBlueForegroundFloat!))
      
    }
    
  }
  
  
  // MARK: Buttons
  
  func turnOnBackgroundButton() {
    setDefaultDisplay()
    displayCurrentSliderValues()
    displayCurrentTextFieldValues()
  }
  
  
  func turnOnForegroundButton() {
    
    backgroundInFocus = false
    
    leftButton.setTitleColor(.white, for: UIControlState())
    rightButton.setTitleColor(UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0), for: UIControlState())
    
    leftButtonUnderline.isHidden = true
    rightButtonUnderline.isHidden = false
    
    leftButtonUnderline.backgroundColor = .white
    rightButtonUnderline.backgroundColor = UIColor(red: 213.0/255.0, green: 79.0/255.0, blue: 63.0/255.0, alpha: 1.0)
    
    displayCurrentTextFieldValues()
    displayCurrentSliderValues()
    
  }
  
  
  // MARK: CoreData Methods
  
  func pullData() {
    
    let fetchRequest: NSFetchRequest<Palautte> = Palautte.fetchRequest()
    
    do {
      
      categories = try context.fetch(fetchRequest)
      
    } catch {
      // error
    }
    
    
  }
  
  
  func saveData() {
    
    var palautte: Palautte!
    
    if palautteToEdit == nil {
      
      palautte = Palautte(context: context)
      
    } else {
      
      palautte = palautteToEdit
      
    }
    
    let bgColor = BackgroundColor(context: context)
    
    palautte.name = name
    palautte.category = category
    
    if let bgRed = currentRedBackgroundFloat {
      bgColor.redValue = String(bgRed)
    }
    
    if let bgGreen = currentGreenBackgroundFloat {
      bgColor.greenValue = String(bgGreen)
    }
    
    if let bgBlue = currentBlueBackgroundFloat {
      bgColor.blueValue = String(bgBlue)
    }
    

    let fgColor = ForegroundColor(context: context)
    
    if let fgRed = currentRedForegroundFloat {
      fgColor.redValue = String(fgRed)
    }
    
    if let fgGreen = currentGreenForegroundFloat {
      fgColor.greenValue = String(fgGreen)
    }
    
    if let fgBlue = currentBlueForegroundFloat {
      fgColor.blueValue = String(fgBlue)
    }
    
    
    palautte.toBackgroundColor = bgColor
    
    palautte.toForegroundColor = fgColor
    
    
    ad.saveContext()
    
    dismiss(animated: true, completion: nil)
    
  }
  
  
  func deleteData() {
    
    if palautteToEdit != nil {
      context.delete(palautteToEdit!)
      ad.saveContext()
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  

  
  func loadData() {
    
    if let item = palautteToEdit {
      
      name = item.name
      category = item.category
      
      currentRedBackgroundFloat = Float(item.toBackgroundColor?.redValue ?? "")
      currentGreenBackgroundFloat = Float(item.toBackgroundColor?.greenValue ?? "")
      currentBlueBackgroundFloat = Float(item.toBackgroundColor?.blueValue ?? "")
      
      currentRedForegroundFloat = Float(item.toForegroundColor?.redValue ?? "")
      currentGreenForegroundFloat = Float(item.toForegroundColor?.greenValue ?? "")
      currentBlueForegroundFloat = Float(item.toForegroundColor?.blueValue ?? "")
      
      let redBack = CGFloat(currentRedBackgroundFloat!/255.0)
      let greenBack = CGFloat(currentGreenBackgroundFloat!/255.0)
      let blueBack = CGFloat(currentBlueBackgroundFloat!/255.0)
      
      let redFore = CGFloat(currentRedForegroundFloat!/255.0)
      let greenFore = CGFloat(currentGreenForegroundFloat!/255.0)
      let blueFore = CGFloat(currentBlueForegroundFloat!/255.0)
      
      
      backgroundContainer.backgroundColor = UIColor.init(red: redBack, green: greenBack, blue: blueBack, alpha: 1.0)
      foregroundContainer.backgroundColor = UIColor.init(red: redFore, green: greenFore, blue: blueFore, alpha: 1.0)
      
    }
    
  }
  
  
  // MARK: TextField Target Actions
  
  func textFieldTextChecker(textField: UITextField) {
    
    guard var text = textField.text else {return}
    
    if let value: Int = NumberFormatter().number(from: text) as Int? {
      var newValue = Float(value)
      let maxVal: Float = 255
      if newValue > maxVal {
        newValue = 255
        textField.text = "255"
      }
      
      if textField == redTextField {
        if backgroundInFocus == true {
          currentRedBackgroundFloat = newValue
          redSlider.setValue(newValue, animated: true)
        } else if !backgroundInFocus! {
          currentRedForegroundFloat = newValue
          redSlider.setValue(newValue, animated: true)
        }
      } else if textField == greenTextField {
        if backgroundInFocus == true {
          currentGreenBackgroundFloat = newValue
          greenSlider.setValue(newValue, animated: true)
        } else if !backgroundInFocus! {
          currentGreenForegroundFloat = newValue
          greenSlider.setValue(newValue, animated: true)
        }
      } else if textField == blueTextField {
        if backgroundInFocus == true {
          currentBlueBackgroundFloat = newValue
          blueSlider.setValue(newValue, animated: true)
        } else if !backgroundInFocus! {
          currentBlueForegroundFloat = newValue
          blueSlider.setValue(newValue, animated: true)
        }
      }
      
    } else {
      
      if textField == redTextField {
        redTextField.text = ""
        redSlider.setValue(0, animated: true)
        if backgroundInFocus == true {
          currentRedBackgroundFloat = 0 as Float
        } else if !backgroundInFocus! {
          currentRedForegroundFloat = 0 as Float
        }
      } else if textField == greenTextField {
        greenTextField.text = ""
        greenSlider.setValue(0, animated: true)
        if backgroundInFocus == true {
          currentGreenBackgroundFloat = 0 as Float
        } else if !backgroundInFocus! {
          currentGreenForegroundFloat = 0 as Float
        }
      } else if textField == blueTextField {
        blueTextField.text = ""
        blueSlider.setValue(0, animated: true)
        if backgroundInFocus == true {
          currentBlueBackgroundFloat = 0 as Float
        } else if !backgroundInFocus! {
          currentBlueForegroundFloat = 0 as Float
        }
      }
    }
    
    if text.characters.count > 3 {
      textField.text = "255"
      if textField == redTextField {
        if backgroundInFocus == true {
          redTextField.text = text
          currentRedBackgroundFloat = round(Float(text)!)
        } else if !backgroundInFocus! {
          redTextField.text = text
          currentRedForegroundFloat = round(Float(text)!)
        }
      } else if textField == greenTextField {
        if backgroundInFocus == true {
          greenTextField.text = text
          currentGreenBackgroundFloat = round(Float(text)!)
        } else if !backgroundInFocus! {
          greenTextField.text = text
          currentGreenForegroundFloat = round(Float(text)!)
        }
      } else if textField == blueTextField {
        if backgroundInFocus == true {
          blueTextField.text = text
          currentBlueBackgroundFloat = round(Float(text)!)
        } else if !backgroundInFocus! {
          blueTextField.text = text
          currentBlueForegroundFloat = round(Float(text)!)
        }
      }
    }
    setBackgroundAndForegroundColors()
  }
  
  
  // MARK: Slider Target Actions
  
  func redSliderAction(sender: UISlider) {
    if backgroundInFocus == true {
      currentRedBackgroundFloat = sender.value
      redTextField.text = String(Int(currentRedBackgroundFloat!))
      currentRedBackgroundFloat = round(sender.value)
    } else if !backgroundInFocus! {
      currentRedForegroundFloat = sender.value
      redTextField.text = String(Int(currentRedForegroundFloat!))
      currentRedForegroundFloat = round(sender.value)
    }
    setBackgroundAndForegroundColors()
  }
  
  func greenSliderAction(sender: UISlider) {
    if backgroundInFocus == true {
      currentGreenBackgroundFloat = sender.value
      greenTextField.text = String(Int(currentGreenBackgroundFloat!))
      currentGreenBackgroundFloat = round(sender.value)
    } else if !backgroundInFocus! {
      currentGreenForegroundFloat = sender.value
      greenTextField.text = String(Int(currentGreenForegroundFloat!))
      currentGreenForegroundFloat = round(sender.value)
    }
    setBackgroundAndForegroundColors()
  }
  
  func blueSliderAction(sender: UISlider) {
    if backgroundInFocus == true {
      currentBlueBackgroundFloat = sender.value
      blueTextField.text = String(Int(currentBlueBackgroundFloat!))
      currentBlueBackgroundFloat = round(sender.value)
    } else if !backgroundInFocus! {
      currentBlueForegroundFloat = sender.value
      blueTextField.text = String(Int(currentBlueForegroundFloat!))
      currentBlueForegroundFloat = round(sender.value)
    }
    setBackgroundAndForegroundColors()
  }
  
  
  func setBackgroundAndForegroundColors() {
    
    let redBackgroundCGFloat = CGFloat(currentRedBackgroundFloat!/255.0)
    let greenBackgroundCGFloat = CGFloat(currentGreenBackgroundFloat!/255.0)
    let blueBackgroundCGFloat = CGFloat(currentBlueBackgroundFloat!/255.0)
    
    let redForegroundCGFloat = CGFloat(currentRedForegroundFloat!/255.0)
    let greenForegroundCGFloat = CGFloat(currentGreenForegroundFloat!/255.0)
    let blueForegroundCGFloat = CGFloat(currentBlueForegroundFloat!/255.0)
    
    backgroundContainer.backgroundColor = UIColor(red: redBackgroundCGFloat, green: greenBackgroundCGFloat, blue: blueBackgroundCGFloat, alpha: 1)
    foregroundContainer.backgroundColor = UIColor(red: redForegroundCGFloat, green: greenForegroundCGFloat, blue: blueForegroundCGFloat, alpha: 1)
    
  }
  
  
  
  @IBAction func leftBarButtonTapped(_ sender: UIBarButtonItem) {
    
    dismiss(animated: true, completion: nil)
    
  }
  
  @IBAction func rightBarButtonTapped(_ sender: UIBarButtonItem) {
    
    deleteData()
    
  }
  
  @IBAction func leftButtonTapped(_ sender: UIButton) {
    
    turnOnBackgroundButton()
    
  }
  
  @IBAction func rightButtonTapped(_ sender: UIButton) {
    
    turnOnForegroundButton()
    
  }
  
  @IBAction func saveButtonTapped(_ sender: UIButton) {
    
    saveData()
    
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
