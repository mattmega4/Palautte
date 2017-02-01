//
//  AddPalautteViewController.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/8/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit
import CoreData

class AddPalautteViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var cancelNavBarButton: UIBarButtonItem!
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  @IBOutlet weak var backgroundCanvas: UIView!
  @IBOutlet weak var foregroundCanvas: UIView!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var characterLimitLabel: UILabel!
  @IBOutlet weak var nameTextFieldUnderline: UIView!
  
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var categoryPickerView: UIPickerView!
  
  @IBOutlet weak var savePalautteButton: UIButton!
  
  var transferredRedBackgroundColorValue: Float?
  var transferredGreenBackgroundColorValue: Float?
  var transferredBlueBackgroundColorValue: Float?
  
  var transferredRedForegroundColorValue: Float?
  var transferredGreenForegroundColorValue: Float?
  var transferredBlueForegroundColorValue: Float?
  
  var finalPalautteNameValue: String?
  var finalPalautteCategoryValue: String?
  
  var textRequirementIsFulfilled = false
  var textLimitRequirementIsFulfilled = true
  var categoryRequirementIsFulfilled = false
  
  var pickerData: [String] = []
  
  
  // MARK: View Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "add palautte"
    
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Copperplate-Bold", size: 20)!]
    
    if let topItem = self.navigationController?.navigationBar.topItem {
      topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    self.nameTextField.delegate = self
    self.categoryPickerView.delegate = self
    self.categoryPickerView.dataSource = self
    
    pickerData+=["Please Select Category", "Books", "Business", "Catalogs", "Education", "Entertainment", "Finance", "Food & Drink", "Games", "Health & Fitness", "Kids", "Lifestyle", "Magazines & Newspapers", "Medical", "Music", "Navigation", "News", "Photo & Video", "Productivity", "Reference", "Shopping", "Social Networking", "Sports", "Travel", "Utilities", "Weather", "Popular Near Me"]
    
    checkIfAllFieldsHaveBeenFulfilled()
    
    nameTextField.addTarget(self, action: #selector(setTextFieldValueToPropertyInPreperationForCoreDataStorage(textField:)), for: .editingChanged)
    nameTextField.addTarget(self, action: #selector(checkIfTextFieldIsTwentyCharactersOrLess(textField:)), for: .editingChanged)
    
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPalautteViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setBackgroundAndForegroundCanvasColors()
    
    let bob = transferredBlueForegroundColorValue ?? 0
    print(bob)
    
    characterLimitLabel.text = "20 Characters Left"
  }
  
  
  // MARK: UITextField
  
  func checkIfTextFieldIsTwentyCharactersOrLess(textField: UITextField) {
    if textField == nameTextField{
      let maxCharLimit = 20
      let currCharCount = textField.text?.characters.count
      let remainingCharCount = maxCharLimit - currCharCount!
      
      if (textField.text?.characters.count)! > 20 {
        textLimitRequirementIsFulfilled = false
        characterLimitLabel.textColor = .red
        characterLimitLabel.text = "\(remainingCharCount) Characters Left"
      } else if (textField.text?.characters.count)! <= 20 {
        textLimitRequirementIsFulfilled = true
        characterLimitLabel.textColor = .white
        characterLimitLabel.text = "\(remainingCharCount) Characters Left"
      }
    }
  }
  
  func setTextFieldValueToPropertyInPreperationForCoreDataStorage(textField: UITextField) {
    
    if textField == nameTextField{
      
      finalPalautteNameValue = textField.text ?? ""
      
      if finalPalautteNameValue == "" {
        textRequirementIsFulfilled = false
      } else {
        textRequirementIsFulfilled = true
      }
    }
    checkIfAllFieldsHaveBeenFulfilled()
  }
  
  
  // MARK: Prepare for Core Data Transfer
  
  func checkIfAllFieldsHaveBeenFulfilled() {
    if textRequirementIsFulfilled == true && categoryRequirementIsFulfilled == true && textLimitRequirementIsFulfilled == true{
      savePalautteButton.alpha = 1.0
      savePalautteButton.isEnabled = true
    } else {
      savePalautteButton.alpha = 0.1
      savePalautteButton.isEnabled = false
    }
  }
  
  
  // MARK: CoreData
  
  func saveToCoreData(){
    
    let palautte = Palautte(context: context)
    
    if let tempName = nameTextField.text {
      palautte.name = tempName
    }
    
    palautte.category = pickerData[categoryPickerView.selectedRow(inComponent: 0)]
    
    
    let bgColor = BackgroundColor(context: context)
    
    
    if let bgRed = transferredRedBackgroundColorValue {
      bgColor.redValue = String(bgRed)
    }
    
    if let bgGreen = transferredGreenBackgroundColorValue {
      bgColor.greenValue = String(bgGreen)
    }
    
    if let bgBlue = transferredBlueBackgroundColorValue {
      bgColor.blueValue = String(bgBlue)
    }
    
    palautte.toBackgroundColor = bgColor
    
    
    let fgColor = ForegroundColor(context: context)
    
    if let fgRed = transferredRedForegroundColorValue {
      fgColor.redValue = String(fgRed)
    }
    
    if let fgGreen = transferredGreenForegroundColorValue {
      fgColor.greenValue = String(fgGreen)
    }
    
    if let fgBlue = transferredBlueForegroundColorValue {
      fgColor.blueValue = String(fgBlue)
    }
    
    palautte.toForegroundColor = fgColor
    

    ad.saveContext()
    
    dismiss(animated: true, completion: nil)
    
    if let tabBarController = self.presentingViewController as? UITabBarController {
      tabBarController.selectedIndex = 1
    }
    
  }
  
  
  // MARK: Background & Foreground Color
  
  func setBackgroundAndForegroundCanvasColors() {
    
    let RBGC = transferredRedBackgroundColorValue ?? 0.0
    let redBackgroundColorValue = CGFloat(RBGC)/255.0
    
    let GBGC = transferredGreenBackgroundColorValue ?? 0.0
    let greenBackgroundColorValue = CGFloat(GBGC)/255.0
    
    let BBGC = transferredBlueBackgroundColorValue ?? 0.0
    let blueBackgroundColorValue = CGFloat(BBGC)/255.0
    
    
    let RFGC = transferredRedForegroundColorValue ?? 0.0
    let redForegroundColorValue = CGFloat(RFGC)/255.0
    
    let GFGC = transferredGreenForegroundColorValue ?? 0.0
    let greenForegroundColorValue = CGFloat(GFGC)/255.0
    
    let BFGC = transferredBlueForegroundColorValue ?? 0.0
    let blueForegroundColorValue = CGFloat(BFGC)/255.0
    
    
    backgroundCanvas.backgroundColor = UIColor(red: redBackgroundColorValue, green: greenBackgroundColorValue, blue: blueBackgroundColorValue, alpha: 1.0)
    
    foregroundCanvas.backgroundColor = UIColor(red: redForegroundColorValue, green: greenForegroundColorValue, blue: blueForegroundColorValue, alpha: 1.0)
    
  }
  
  
  // MARK: UIPickerView Delegate Methods
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let titleData = pickerData[row]
    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
    return myTitle
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if row == 0{
      // Please Select Category
      categoryRequirementIsFulfilled = false
      finalPalautteCategoryValue = ""
      checkIfAllFieldsHaveBeenFulfilled()
    } else {
      // Everything else
      categoryRequirementIsFulfilled = true
      finalPalautteCategoryValue = pickerData[row]
      checkIfAllFieldsHaveBeenFulfilled()
    }
  }
  
  
  // MARK: UITextField
  
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
  
  @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addPalautteButtonTapped(_ sender: UIButton) {
    
    saveToCoreData()
  }
  
  
  // MARK: Keyboard Methods
  
  func keyboardWillShow(notification:NSNotification) {
    var userInfo = notification.userInfo!
    var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    var contentInset: UIEdgeInsets = self.scrollView.contentInset
    contentInset.bottom = keyboardFrame.size.height + 30
    self.scrollView.contentInset = contentInset
    categoryPickerView.isUserInteractionEnabled = false
  }
  
  func keyboardWillHide(notification:NSNotification) {
    let contentInset:UIEdgeInsets = UIEdgeInsets.zero
    self.scrollView.contentInset = contentInset
    categoryPickerView.isUserInteractionEnabled = true
  }
  
  func dismissKeyboard() {
    categoryPickerView.endEditing(true)
    view.endEditing(true)
  }
  
}



