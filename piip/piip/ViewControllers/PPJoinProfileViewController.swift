//
//  PPJoinProfileViewController.swift
//  piip
//
//  Created by Johannes on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class PPJoinProfileViewController: PPTableViewController {
    
    enum ProfileSectionIndex: Int {
        case SECT_NAME
        case SECT_STATUS
        case SECT_BIRTHDAY
        case SECT_GENDER
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    private weak var nameTextField: UITextField?
    private weak var statusTextField: UITextField?
    
    private let imagePicker = UIImagePickerController()
    
    private let genderList = ["Female", "Male", "Other", "Not Specified"]
    
    var name: String?
    var status: String?
    var genderIndex: Int?
    var dateOfBirth: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // transparent Navigation Bar
        self.imagePicker.delegate = self;
        
        // Navigation bar appearance
        self.navigationController?.navigationBar.letToNormal()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Profile tap action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PPJoinProfileViewController.onTapProfileImage(_:)))
        self.profileImageView.addGestureRecognizer(tapGesture)
        self.profileImageView.userInteractionEnabled = true
        
        // Dispose of any resources that can be recreated.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapDone(sender: UIBarButtonItem) {
        
        // Save param
        self.name = self.nameTextField?.text
        self.status = self.statusTextField?.text
        
        // check name is empty
        if self.name?.isEmpty == true {
            self.showAlertWithTitle("Profile", message: "You must enter display name", yesCompletion: {
                
                self.selectTableCell(forRow: 0, inSection: ProfileSectionIndex.SECT_NAME.rawValue)
                
                }, noCompletion: nil)
        }
        else if self.dateOfBirth == nil {
            self.showAlertWithTitle("Profile", message: "You must enter birthday", yesCompletion: {
                
                self.selectTableCell(forRow: 0, inSection: ProfileSectionIndex.SECT_BIRTHDAY.rawValue)
                
                }, noCompletion: nil)
        }
    }
    
    func onTapProfileImage(sender: AnyObject) {
        
        //show the action sheet (i.e. the little pop-up box from the bottom that allows you to choose whether you want to pick a photo from the photo library or from your camera
        let optionMenu = UIAlertController(title: nil, message: "Where would you like the image from?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let photoLibraryOption = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            //shows the photo library
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .PhotoLibrary
            self.imagePicker.modalPresentationStyle = .Popover
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
        
        let cameraOption = UIAlertAction(title: "Take a photo", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            //shows the camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .Camera
            self.imagePicker.modalPresentationStyle = .Popover
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        })
        
        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        //Adding the actions to the action sheet. Camera will only show up as an option if the camera is available in the first place.
        optionMenu.addAction(photoLibraryOption)
        optionMenu.addAction(cancelOption)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
            optionMenu.addAction(cameraOption)} else {
        }
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
}

// MARK: - Table view data source & delegate
extension PPJoinProfileViewController {
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PPJoinProfileTableViewCell
        
        // Configure the cell...
        cell.selectionStyle = .None
        self.configureCell(indexPath, cell: cell)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PPJoinProfileTableViewCell
        
        switch (indexPath.section) {
        case ProfileSectionIndex.SECT_NAME.rawValue: // Name
            cell.textField?.becomeFirstResponder()
            break
            
        case ProfileSectionIndex.SECT_STATUS.rawValue: // Status
            cell.textField?.becomeFirstResponder()
            break
            
        case ProfileSectionIndex.SECT_BIRTHDAY.rawValue: // Birthday
            // Dismiss keyboard and display Date selection
            self.view.endEditing(true)
            self.selectBirthday(cell)
            break
            
        case ProfileSectionIndex.SECT_GENDER.rawValue: // Gender
            // Dismiss keyboard and display Gender selection
            self.view.endEditing(true)
            self.selectGender(cell)
            break
            
        default:
            break
        }
    }
    
    private func configureCell(indexPath: NSIndexPath, cell: PPJoinProfileTableViewCell) {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PPJoinProfileTableViewCell
        
        switch (indexPath.section) {
        
        case ProfileSectionIndex.SECT_NAME.rawValue:  // Name
            cell.textField?.text = self.name
            
            // nameTextField
            self.nameTextField = cell.textField
            self.nameTextField?.delegate = self
            break
            
        case ProfileSectionIndex.SECT_STATUS.rawValue: // Status
            cell.textField?.text = self.status
            
            // set statusTextField
            self.statusTextField = cell.textField
            self.statusTextField?.delegate = self
            break
            
        case ProfileSectionIndex.SECT_BIRTHDAY.rawValue: // Birthday
            cell.label?.text = self.dateOfBirth?.getHumanReadableString()
            break
            
        case ProfileSectionIndex.SECT_GENDER.rawValue: // Gender
            
            if let genderIndex = self.genderIndex {
                cell.label?.text = self.genderList[genderIndex]
            }
            else {
                cell.label?.text = ""
            }
            
            break
            
        default:
            break
        }
    }
    
    private func selectGender(cell: PPJoinProfileTableViewCell) {
        
        self.name = self.nameTextField?.text
        self.status = self.statusTextField?.text
        
        var _genderIndex : Int = 0
        if let index = self.genderIndex {
            _genderIndex = index
        }
        
        // Create stringPicker
        let picker = ActionSheetStringPicker(title: "Select gender", rows: self.genderList, initialSelection: _genderIndex, doneBlock: { (picker, index, object) -> Void in
            
            self.genderIndex = index
            self.tableView.reloadData()
            
            }, cancelBlock: { (picker) -> Void in
                
            }, origin: cell)
        
        picker.setDoneButton(UIBarButtonItem.pp_CustomBarButton(withTitle: "Done"))
        picker.setCancelButton(UIBarButtonItem.pp_CustomBarButton(withTitle: "Cancel"))
        
        picker.showActionSheetPicker()
    }
    
    private func selectBirthday(cell: PPJoinProfileTableViewCell) {
        
        self.name = self.nameTextField?.text
        self.status = self.statusTextField?.text
        
        // Set current selection date if possible
        let currentDate = NSDate()
        var selectionDate = currentDate.pp_dateByAddingYearInterval(-18)
        if let _dodSelected = self.dateOfBirth {
            selectionDate = _dodSelected
        }
        
        // Create datePicker
        let datePicker = ActionSheetDatePicker(title: "Select date", datePickerMode: .Date, selectedDate: selectionDate, doneBlock: { (picker, selectedDate, index) -> Void in
            
            // Forward selected date
            self.dateOfBirth = selectedDate as? NSDate
            
            // select Gendor
            self.selectTableCell(forRow: 0, inSection: ProfileSectionIndex.SECT_GENDER.rawValue)
            self.tableView.reloadData()
            
            }, cancelBlock: { (picker) -> Void in
                
            }, origin: cell)
        
        // Maximum select date
        datePicker.maximumDate = currentDate.pp_dateByAddingYearInterval(-18)
        
        // Customize done button
        datePicker.setDoneButton(UIBarButtonItem.pp_CustomBarButton(withTitle: "Next"))
        datePicker.setCancelButton(UIBarButtonItem.pp_CustomBarButton(withTitle: "Cancel"))
        
        // Hide cancel button
        datePicker.hideCancel = false
        
        // Show in view
        datePicker.showActionSheetPicker()
    }
    
    private func selectTableCell(forRow row: Int, inSection section: Int) {
        let index = NSIndexPath(forRow: row, inSection: section)
        self.tableView.selectRowAtIndexPath(index, animated: true, scrollPosition: .Middle)
        self.tableView(self.tableView, didSelectRowAtIndexPath: index)
    }
}

// MARK: - Image Picker Delegates
extension PPJoinProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.profileImageView.image = chosenImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension PPJoinProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            self.name = self.nameTextField?.text
            
            self.statusTextField?.becomeFirstResponder()
            
        } else if textField == self.statusTextField {
            self.status = self.statusTextField?.text
            self.view.endEditing(true)
            
            self.selectTableCell(forRow: 0, inSection: ProfileSectionIndex.SECT_BIRTHDAY.rawValue)
        }
        return false;
    }

}

