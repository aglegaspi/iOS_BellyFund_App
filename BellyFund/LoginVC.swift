//
//  LoginVC.swift
//  BellyFund
//
//  Created by Alex 6.1 on 11/5/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    //MARK: VIEWS
    
    lazy var bellyFundLabel: UILabel = {
        var label = UILabel()
        label.text = "BellyFund"
        label.font = UIFont.init(name: "AvenirNext-BoldItalic", size: 60.0)
        label.textAlignment = .center
        return label
    }()
    
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
        tf.placeholder = "passsord"
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
        view.backgroundColor = UIColor(red: 0.633, green: 0.162, blue: 0.259, alpha: 1.0)
        addSubViews()
        addPadding()
        addConstraints()
    }
    
    //MARK: FUNCTIONS
    private func addSubViews() {
        view.addSubview(bellyFundLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
    }
    
    private func addConstraints() {
        constrainBellyFundLabel()
        constrainEmailTextField()
        constrainPasswordTextField()
        constrainLoginButton()
    }
    
    private func addPadding() {
        addPaddingForTextFields(emailTextField)
        addPaddingForTextFields(passwordTextField)
    }
    
    private func addPaddingForTextFields(_ nameOfTextField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: nameOfTextField.frame.height))
        nameOfTextField.leftView = paddingView
        nameOfTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: CONSTRAINTS FOR VIEWS
    private func constrainBellyFundLabel() {
        bellyFundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bellyFundLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            bellyFundLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bellyFundLabel.widthAnchor.constraint(equalToConstant: 300),
            bellyFundLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: bellyFundLabel.bottomAnchor, constant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainLoginButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            submitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: OBJC FUNCTIONS
    @objc func loginButtonPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(with: "All Fields Required", and: "Enter valid email and password.")
            return
        }
        
        guard email.isValidEmail else {
            showAlert(with: "Invalid Email Address", and: "Please re-enter email address.")
            return
        }
        
        guard password.isValidPassword else {
            showAlert(with: "Invalid Password", and: "Please re-enter password")
            return
        }
        
        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
            self.handleLoginResponse(with: result)
        }
    }
    
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            showAlert(with: "Error", and: "Could not log in. Error: \(error)")
        case .success:
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    //MARK: TODO - handle could not swap root view controller
                    return
            }
            
            //MARK: TODO - refactor this logic into scene delegate
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                    window.rootViewController = ViewController()
                } else {
                    //window.rootViewController = {
                        //let profileSetupVC = ProfileEditViewController()
                        //profileSetupVC.settingFromLogin = true
                        //return profileSetupVC
                    //}()
                }
            }, completion: nil)
        }
    }
}


extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
}

