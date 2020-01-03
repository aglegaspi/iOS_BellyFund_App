//
//  PostVC.swift
//  BellyFund
//
//  Created by Alex 6.1 on 12/16/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class PostVC: UIViewController {
    
    var nameOfItemTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter User Name"
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.backgroundColor = .init(white: 1.0, alpha: 0.2)
        textField.textColor = .black
        textField.font?.withSize(30)
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    var descriptionOfItemTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.autocorrectionType = .yes
        textView.spellCheckingType = .yes
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.947, green: 0.586, blue: 0.798, alpha: 1.0)
        loadSubviews()
        loadConstraints()
        nameOfItemTextField.delegate = self
        descriptionOfItemTextView.delegate = self
    }
    
    private func loadSubviews() {
        view.addSubview(nameOfItemTextField)
        view.addSubview(descriptionOfItemTextView)
    }
    
    private func loadConstraints() {
        constrainNameOfItem()
        constrainDescriptionOfItem()
    }
    
    private func constrainNameOfItem() {
        nameOfItemTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameOfItemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameOfItemTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameOfItemTextField.widthAnchor.constraint(equalToConstant: view.frame.maxX / 2)
        ])
    }
    
    private func constrainDescriptionOfItem() {
        descriptionOfItemTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionOfItemTextView.topAnchor.constraint(equalTo: nameOfItemTextField.bottomAnchor, constant: 10),
            descriptionOfItemTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            descriptionOfItemTextView.widthAnchor.constraint(equalToConstant: view.frame.maxX / 2),
            descriptionOfItemTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }


}


/*
 let name: String?
 let photoURL: String?
 let description: String?
 let userName: String?
 let userID: String?
 let ingredients: String?
 let price: Double?
 let contributions: Int?
 let priceForEachContributor: Double?
 let itemID: String?
 let dateCreated: Date?
 let endDate: Date?
 let contributors: [String]?
 */

extension PostVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension PostVC: UITextViewDelegate {
    
    
}
