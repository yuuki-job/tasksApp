//
//  apendTaskViewController.swift
//  taskApp1
//
//  Created by 徳永勇希 on 2020/09/06.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class apendTaskViewController: UIViewController, UIPickerViewDataSource {
    
    
    
    

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var datepickerView = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

       createPickerView()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
    func createPickerView() {
        //datepickerView.delegate = self
        dateTextField.inputView = datepickerView
        // toolbar
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(apendTaskViewController.donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func donePicker() {
        dateTextField.endEditing(true)
    }
    
    
    @IBAction func taskApendButton(_ sender: Any) {
        
        
    }
    
}
