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
  
  var transferredRedBackgroundColorValue: Float = 255
  var transferredGreenBackgroundColorValue: Float = 255
  var transferredBlueBackgroundColorValue: Float = 255
  
  var transferredRedForegroundColorValue: Float = 0
  var transferredGreenForegroundColorValue: Float = 0
  var transferredBlueForegroundColorValue: Float = 0
  
  
  var redBackgroundColorValue: CGFloat = 255.0/255.0
  var greenBackgroundColorValue: CGFloat = 255.0/255.0
  var blueBackgroundColorValue: CGFloat = 255.0/255.0
  
  var redForegroundColorValue: CGFloat = 0.0/255.0
  var greenForegroundColorValue: CGFloat = 0.0/255.0
  var blueForegroundColorValue: CGFloat = 0.0/255.0
  
  var finalPalautteNameValue: String = "Untitled Palautte"
  var finalPalautteCategoryValue: String = "Uncategorizdd"
  
  var textRequirementIsFulfilled = false
  var textLimitRequirementIsFulfilled = true
  var categoryRequirementIsFulfilled = false
  
  var pickerData: [String] = []
  
  
  // MARK: View Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "add palautte"
    
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Copperplate-Bold", size: 20)!]
    
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
    characterLimitLabel.text = "20 Characters Left"
  }
  
  
  //MARK: UITextField
  
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
      if let tempText = textField.text{
        finalPalautteNameValue = tempText
        if finalPalautteNameValue.isEmpty{
          textRequirementIsFulfilled = false
        } else {
          textRequirementIsFulfilled = true
        }
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
    
    
    
  }
  
  
  // MARK: Background & Foreground Color
  
  func setBackgroundAndForegroundCanvasColors() {
    
    let RBGC = CGFloat(transferredRedBackgroundColorValue)
    redBackgroundColorValue = RBGC/255.0
    
    let GBGC = CGFloat(transferredGreenBackgroundColorValue)
    greenBackgroundColorValue = GBGC/255.0
    
    let BBGC = CGFloat(transferredBlueBackgroundColorValue)
    blueBackgroundColorValue = BBGC/255.0
    
    
    let RFGC = CGFloat(transferredRedForegroundColorValue)
    redForegroundColorValue = RFGC/255.0
    
    let GFGC = CGFloat(transferredGreenForegroundColorValue)
    greenForegroundColorValue = GFGC/255.0
    
    let BFGC = CGFloat(transferredBlueForegroundColorValue)
    blueForegroundColorValue = BFGC/255.0
    
    
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
    print("foo")
    print(finalPalautteNameValue)
    print("bar")
    print(finalPalautteCategoryValue)
  }
  
  
  // MARK: Keyboard Methods
  
  func keyboardWillShow(notification:NSNotification) {
    var userInfo = notification.userInfo!
    var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    var contentInset: UIEdgeInsets = self.scrollView.contentInset
    contentInset.bottom = keyboardFrame.size.height
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



