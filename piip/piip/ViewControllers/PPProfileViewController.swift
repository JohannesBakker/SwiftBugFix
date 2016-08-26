//
//  PPProfileViewController.swift
//  piip
//
//  Created by Johannes on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class PPProfileViewController: PPTableViewController {
    
    enum ProfileSectionIndex: Int {
        case SECT_LIST
        case SECT_BIRTHDAY
        case SECT_GENDER
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var editNameImageView: UIImageView!
    @IBOutlet weak var editStatusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private let imagePicker = UIImagePickerController()
    
    private let genderList = ["Female", "Male", "Other", "Not Specified"]
    
    var bUpdateProfile: Bool?
    var name: String?
    var status: String?
    var genderIndex: Int?
    var dateOfBirth: NSDate?
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_profile"), tag: 4)
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background tap action
        let tapBackgroundGesture = UITapGestureRecognizer(target: self, action: #selector(PPProfileViewController.onTapBackgroundImage(_:)))
        self.backgroundImageView.addGestureRecognizer(tapBackgroundGesture)
        self.backgroundImageView.userInteractionEnabled = true
        
        // Profile tap action
        let tapProfileGesture = UITapGestureRecognizer(target: self, action: #selector(PPJoinProfileViewController.onTapProfileImage(_:)))
        self.profileImageView.addGestureRecognizer(tapProfileGesture)
        self.profileImageView.userInteractionEnabled = true
        
        // profile border
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.layer.borderColor = UIColor.pp_mainTintColor().CGColor
        
        // Name tap action
        let tapNameGesture = UITapGestureRecognizer(target: self, action: #selector(PPProfileViewController.onTapName(_:)))
        self.nameLabel.addGestureRecognizer(tapNameGesture)
        self.nameLabel.userInteractionEnabled = true
        
        let tapEditNameGesture = UITapGestureRecognizer(target: self, action: #selector(PPProfileViewController.onTapName(_:)))
        self.editNameImageView.addGestureRecognizer(tapEditNameGesture)
        self.editNameImageView.userInteractionEnabled = true
        
        // Status tap action
        let tapStatusGesture = UITapGestureRecognizer(target: self, action: #selector(PPProfileViewController.onTapStatus(_:)))
        self.statusLabel.addGestureRecognizer(tapStatusGesture)
        self.statusLabel.userInteractionEnabled = true
        
        let tapEditStatusGesture = UITapGestureRecognizer(target: self, action: #selector(PPProfileViewController.onTapStatus(_:)))
        self.editStatusImageView.addGestureRecognizer(tapEditStatusGesture)
        self.editStatusImageView.userInteractionEnabled = true
        
        
        self.imagePicker.delegate = self;
        
        self.bUpdateProfile = true
        
        // Dispose of any resources that can be recreated.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTapProfileImage(sender: AnyObject) {
        updateImage(updateProfile: true)
    }
    
    func onTapBackgroundImage(sender: AnyObject) {
        updateImage(updateProfile: false)
    }
    
    func onTapName(sender: AnyObject) {
        self.showAlertWithTextField("Edit name",
                                    message: nil,
                                    placeholderText: self.name,
                                    yesCompletion: { (newName) -> Void in
                                        self.nameLabel.text = newName
                                        self.name = newName
            },
                                    noCompletion: nil)
    }
    
    func onTapStatus(sender: AnyObject) {
        self.showAlertWithTextField("Edit status",
                                    message: nil,
                                    placeholderText: self.name,
                                    yesCompletion: { (newStatus) -> Void in
                                        self.statusLabel.text = newStatus
                                        self.status = newStatus
            },
                                    noCompletion: nil)
    }
    
    private func updateImage(updateProfile isProfile: Bool) {
        self.bUpdateProfile = isProfile
        
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

// MARK: - Image Picker Delegates
extension PPProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if bUpdateProfile == true {
            self.profileImageView.image = chosenImage
        } else {
            self.backgroundImageView.image = chosenImage
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - Table view data source & delegate

extension PPProfileViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PPProfileTableViewCell
        
        // Configure the cell...
        cell.selectionStyle = .None
        self.configureCell(indexPath, cell: cell)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PPProfileTableViewCell
        
        // Dismiss keyboard and display Date selection
        self.view.endEditing(true)
        
        switch (indexPath.section, indexPath.row) {
        case (ProfileSectionIndex.SECT_LIST.rawValue, 0):  // Following list
            self.selectFollowList()
            break
            
        case (ProfileSectionIndex.SECT_LIST.rawValue, 1):  // Blocked list
            self.selectBlockedList()
            break
            
        case (ProfileSectionIndex.SECT_BIRTHDAY.rawValue, 0):  // Birthday
            self.selectBirthday(cell)
            break
            
        case (ProfileSectionIndex.SECT_GENDER.rawValue, 0):  // Gender
            self.selectGender(cell)
            break
            
        default:
            break
        }
    }
    
    private func configureCell(indexPath: NSIndexPath, cell: PPProfileTableViewCell) {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PPProfileTableViewCell
        
        switch (indexPath.section, indexPath.row) {
        case (ProfileSectionIndex.SECT_LIST.rawValue, 0):  // Following list
            break
            
        case (ProfileSectionIndex.SECT_LIST.rawValue, 1):  // Blocked list
            break
            
        case (ProfileSectionIndex.SECT_BIRTHDAY.rawValue, 0):  // Birthday
            cell.label?.text = self.dateOfBirth?.getFormattedString()
            break
            
        case (ProfileSectionIndex.SECT_GENDER.rawValue, 0):  // Gender
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
    
    private func selectGender(cell: PPProfileTableViewCell) {
        
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
    
    private func selectBirthday(cell: PPProfileTableViewCell) {
        
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
            
            self.tableView.reloadData()
            
            }, cancelBlock: { (picker) -> Void in
                
            }, origin: cell)
        
        // Maximum select date
        datePicker.maximumDate = currentDate.pp_dateByAddingYearInterval(-18)
        
        // Customize done button
        datePicker.setDoneButton(UIBarButtonItem.pp_CustomBarButton(withTitle: "Done"))
        datePicker.setCancelButton(UIBarButtonItem.pp_CustomBarButton(withTitle: "Cancel"))
        
        // Hide cancel button
        datePicker.hideCancel = false
        
        // Show in view
        datePicker.showActionSheetPicker()
    }
    
    private func selectFollowList() {
        // TODO
    }
    
    private func selectBlockedList() {
        // TODO
    }

}
