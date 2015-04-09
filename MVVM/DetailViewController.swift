//
//  AddViewController.swift
//  MVVM
//
//  Created by carlos on 8/4/15.
//  Copyright (c) 2015 Carlos García. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailViewModelDelegate {
    
    var viewModel: DetailViewModel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        nameField.text = viewModel.name
        amountField.text = viewModel.amount
        nameField.becomeFirstResponder()
    }
    
    
    // MARK: - AddViewModelDelegate
    
    func showInvalidName() {
        UIAlertView(title: "Error", message: "Invalid name", delegate: nil, cancelButtonTitle: "OK").show()
        nameField.becomeFirstResponder()
    }
    
    func showInvalidAmount() {
        UIAlertView(title: "Error", message: "Invalid amount", delegate: nil, cancelButtonTitle: "OK").show()
        amountField.becomeFirstResponder()
    }
    
    func dismissAddView() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    // MARK: - IBActions
    
    @IBAction func cancelPressed(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        viewModel.name = nameField.text ?? ""
        viewModel.amount = amountField.text ?? ""
        viewModel.handleDonePressed()
    }

}
