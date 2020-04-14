//
//  CreateUserViewController.swift
//  CoreData-NumberFacts
//
//  Created by Juan Ceballos on 4/8/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ createUserViewController: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     // set a max date of dob
        datePicker.maximumDate = Date()
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let userNameText = userNameTextField.text,
            !userNameText.isEmpty   else    {
                print("missing user name")
                return
        }
        
        // extract date from date picker
        let date = datePicker.date
        
        let user = CoreDataManager.shared.createUser(name: userNameText, dob: date)
        
        delegate?.didCreateUser(self, user: user)
        // UserViewController will now have access to
        dismiss(animated: true)
    }
    
    
}
