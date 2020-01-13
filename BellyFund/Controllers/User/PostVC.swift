//
//  PostVC.swift
//  BellyFund
//
//  Created by Alex 6.1 on 12/16/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//
import UIKit
import FirebaseAuth
import Photos
import UITextView_Placeholder


class PostVC: UIViewController {
    
    var nameOfItemTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name of Item"
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font?.withSize(30)
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    var itemImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "camera")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var imageButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(imageButtonPressed), for: .touchDown)
        return button
    }()
    
    var descriptionOfItemTextView: UITextView = {
        let textView = UITextView()
        textView.placeholder = "Description of Item"
        textView.isEditable = true
        textView.autocorrectionType = .yes
        textView.spellCheckingType = .yes
        return textView
    }()
    
    var ingredientsOfItemTextView: UITextView = {
        let textView = UITextView()
        textView.placeholder = "Enter Ingredients Here"
        textView.isEditable = true
        textView.autocorrectionType = .yes
        textView.spellCheckingType = .yes
        return textView
    }()
    
    var submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(submitButtonClicked), for: .touchDown)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.947, green: 0.586, blue: 0.798, alpha: 1.0)
        loadConstraints()
        nameOfItemTextField.delegate = self
        descriptionOfItemTextView.delegate = self
    }
    
    
    private func loadConstraints() {
        constrainNameOfItem()
        constrainImage()
        constrainImageButton()
        constrainDescriptionOfItem()
        constrainIngredientsOfItem()
        constrainSubmitButton()
    }
    
    private func constrainNameOfItem() {
        view.addSubview(nameOfItemTextField)
        nameOfItemTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameOfItemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameOfItemTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameOfItemTextField.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5)
        ])
    }
    
    private func constrainImage() {
        view.addSubview(itemImage)
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: nameOfItemTextField.bottomAnchor, constant: 10),
            itemImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            itemImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func constrainImageButton() {
        view.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: nameOfItemTextField.bottomAnchor, constant: 10),
            imageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageButton.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            imageButton.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func constrainDescriptionOfItem() {
        view.addSubview(descriptionOfItemTextView)
        descriptionOfItemTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionOfItemTextView.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            descriptionOfItemTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            descriptionOfItemTextView.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            descriptionOfItemTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func constrainIngredientsOfItem() {
        view.addSubview(ingredientsOfItemTextView)
        ingredientsOfItemTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsOfItemTextView.topAnchor.constraint(equalTo: descriptionOfItemTextView.bottomAnchor, constant: 10),
            ingredientsOfItemTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ingredientsOfItemTextView.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            ingredientsOfItemTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func constrainSubmitButton() {
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: ingredientsOfItemTextView.bottomAnchor, constant: 10),
            submitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            submitButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func photoPicker() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    
    @objc func submitButtonClicked() {
        self.present(ShowAlert.prompt(with: "To-Do", and: "add functionality to save to Firebase"), animated: true, completion: nil)
    }
    
    @objc func imageButtonPressed() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized: self?.photoPicker()
                case .denied: print("Denied photo library permissions")
                default: print("No usable status")
                }
            })
        default: photoPicker()
        }
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

extension PostVC: UITextViewDelegate {}

extension PostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            present(ShowAlert.prompt(with: "Error", and: "Couldn't get image"), animated: true, completion: nil)
            return
        }
        
        self.itemImage.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            present(ShowAlert.prompt(with: "Error", and: "Could not compress image"), animated: true, completion: nil)
            return
        }
        
        //TO-DO: ADD FIREBASE STORAGE SERVICE
//        FirebaseStorageService.profileManager.storeImage(image: imageData, completion: { [weak self] (result) in
//            switch result{
//            case .success(let url): return (self?.imageURL = url)!
//            case .failure(let error): print(error)
//            }
//        })
        
        dismiss(animated: true, completion: nil)
    }
}
