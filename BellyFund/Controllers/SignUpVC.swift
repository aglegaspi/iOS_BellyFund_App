//
//  SignUpVC.swift
//  BellyFund
//
//  Created by Alex 6.1 on 11/19/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
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
        tf.placeholder = "enter your email"
        tf.autocapitalizationType = .none
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "set your password"
        tf.autocapitalizationType = .none
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy var submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpNewUserPressed), for: .touchDown)
        return button
    }()
    
    lazy var dismissButton: UIButton = {
        var button = UIButton()
        button.setTitle("DON'T NEED TO SIGN UP? RETURN TO LOGIN HERE!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-LightOblique", size: 12.0)!
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissButtonPressed), for: .touchDown)
        return button
    }()
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.000, green: 0.737, blue: 0.681, alpha: 1.0)
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
        view.addSubview(dismissButton)
    }
    
    private func addConstraints() {
        constrainBellyFundLabel()
        constrainEmailTextField()
        constrainPasswordTextField()
        constrainLoginButton()
        constrainDismissButton()
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
    
    private func constrainDismissButton() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            dismissButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 300),
            dismissButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: OBJC FUNCTIONS
    @objc func signUpNewUserPressed() {
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
                    window.rootViewController = {
                    let mainVC = ViewController()
                    //profileSetupVC.settingFromLogin = true
                    return mainVC
                    }()
                }
            }, completion: nil)
        }
    }
    
    @objc func dismissButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}


extension SignUpVC: UITextFieldDelegate {
    
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
