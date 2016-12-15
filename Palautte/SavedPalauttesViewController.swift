//
//  SavedPalauttesViewController.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/10/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import UIKit
import CoreData

class SavedPalauttesViewController: UIViewController{
  
  @IBOutlet weak var editNavBarButton: UIBarButtonItem!
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  @IBOutlet weak var tableView: UITableView!
  
  var controller: NSFetchedResultsController<Palautte>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Saved Palauttes"
    
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Copperplate-Bold", size: 20)!]
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    attemptFetch()
    generateTestData()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  
  //TODO: Temporary...Finish Devslopes
  
  func generateTestData() {
    
    
    let item = Palautte(context: context)
    item.name = "Snickers"
    item.category = "KITTY"
    
    let item1 = Palautte(context: context)
    item1.name = "Maximus"
    item1.category = "KITTY"
    
    let item2 = Palautte(context: context)
    item2.name = "EOWYN"
    item2.category = "KITTY"
    
    ad.saveContext()
    
  }
  
  
  // MARK: IBActions
  
  @IBAction func editNavBarButtonTapped(_ sender: UIBarButtonItem) {
  }
  
} // End of SavedPalauttesViewController Class


// MARK: UITableViewDelegate Methods

extension SavedPalauttesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 143
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
  }
  
}


// MARK: UITableViewDataSource Methods

extension SavedPalauttesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "palautteCell", for: indexPath) as! LocalPalautteTableViewCell
    configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
    return cell
  }
  
  func configureCell(cell: LocalPalautteTableViewCell, indexPath: NSIndexPath) {
    let palautte = controller.object(at: indexPath as IndexPath)
    cell.configureCell(palautte: palautte)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = controller.sections {
      let sectionInfo = sections[section]
      return sectionInfo.numberOfObjects
    }
    return 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if let sections = controller.sections {
      return sections.count
    }
    return 0
  }
  
}


// MARK: NSFetchedResultsControllerDelegate

extension SavedPalauttesViewController: NSFetchedResultsControllerDelegate {
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    
    
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    
    
    tableView.endUpdates()
  }
  
  
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    
    switch(type) {
      
    case .insert:
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
      
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      break
      
    case.update:
      if let indexPath = indexPath{
        let cell = tableView.cellForRow(at: indexPath) as! LocalPalautteTableViewCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
      }
      break
      
    case .move:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
      
    }
  }
  
  func attemptFetch() {
    
    let fetchRequest: NSFetchRequest<Palautte> = Palautte.fetchRequest()
    
    let nameSort = NSSortDescriptor(key: "name", ascending: false)
    fetchRequest.sortDescriptors = [nameSort]
    
    let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    
    self.controller = controller
    
    do {
      
      try controller.performFetch()
      
    } catch {
      
      let error = error as NSError
      print("\(error)")
      
    }
    
//    let categorySort = NSSortDescriptor(key: "category", ascending: false)
    
    
  }
  
}
