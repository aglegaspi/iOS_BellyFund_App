//
//  LoginVC.swift
//  BellyFund
//
//  Created by Alex 6.1 on 11/5/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit
//TO-DO: IMPORT WHICH FIREBASE?

class LoginVC: UIViewController {
    
    //MARK: VIEWS
    lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "email"
        tf.autocapitalizationType = .none
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "email"
        tf.autocapitalizationType = .none
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy var submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("Log In", for: .normal)
        return button
    }()
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        addSubViews()
        addPaddingForTextFields()
        addConstraints()
    }
    
    //TO-DO: FUNC SUBVIEWS
    private func addSubViews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
    }
    
    private func addConstraints() {
        constrainEmailTextField()
    }
    
    private func addPaddingForTextFields() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    //TO-DO:  FUNC CONSTRAINTS
    private func constrainEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    

}

