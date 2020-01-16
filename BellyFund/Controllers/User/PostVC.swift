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
    
    var imageToUpload: Data?
    var imageURL: URL? = nil
    
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
    
    var priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Price of Item"
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font?.withSize(30)
        textField.borderStyle = .roundedRect
        return textField
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
        loadSubviews()
        nameOfItemTextField.delegate = self
        descriptionOfItemTextView.delegate = self
        priceTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadConstraints()
    }
    
    private func loadSubviews() {
        view.addSubview(nameOfItemTextField)
        view.addSubview(itemImage)
        view.addSubview(imageButton)
        view.addSubview(descriptionOfItemTextView)
        view.addSubview(ingredientsOfItemTextView)
        view.addSubview(priceTextField)
        view.addSubview(submitButton)
    }
    
    private func loadConstraints() {
        constrainNameOfItem()
        constrainImage()
        constrainImageButton()
        constrainDescriptionOfItem()
        constrainIngredientsOfItem()
        constrainPriceOfItem()
        constrainSubmitButton()
    }
    
    private func constrainNameOfItem() {
        
        nameOfItemTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameOfItemTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameOfItemTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameOfItemTextField.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5)
        ])
    }
    
    private func constrainImage() {
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: nameOfItemTextField.bottomAnchor, constant: 10),
            itemImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            itemImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func constrainImageButton() {
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: nameOfItemTextField.bottomAnchor, constant: 10),
            imageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageButton.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            imageButton.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func constrainDescriptionOfItem() {
        
        descriptionOfItemTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionOfItemTextView.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            descriptionOfItemTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            descriptionOfItemTextView.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            descriptionOfItemTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func constrainIngredientsOfItem() {
        
        ingredientsOfItemTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsOfItemTextView.topAnchor.constraint(equalTo: descriptionOfItemTextView.bottomAnchor, constant: 10),
            ingredientsOfItemTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ingredientsOfItemTextView.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5),
            ingredientsOfItemTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func constrainPriceOfItem() {
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceTextField.topAnchor.constraint(equalTo: ingredientsOfItemTextView.bottomAnchor, constant: 10),
            priceTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            priceTextField.widthAnchor.constraint(equalToConstant: view.frame.maxX / 1.5)
        ])
    }
    
    private func constrainSubmitButton() {
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 10),
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
    
    //MARK: OBJC FUNCTIONS
    @objc func imageButtonPressed() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized: self?.photoPicker()
                case .denied:
                    self?.present(ShowAlert.prompt(with: "Access Denied", and: "Denied photo library permissions"), animated: true, completion: nil)
                default:
                    self?.present(ShowAlert.prompt(with: "Error", and: "No usable status"), animated: true, completion: nil)
                }
            })
        default: photoPicker()
        }
    }
    
    
    @objc func submitButtonClicked() {
        print("submit pressed")
        guard let user = FirebaseAuthService.manager.currentUser else {return}
        print(user.uid)
        //guard let photoURL = imageURL else {return}
        guard let nameOfItem = nameOfItemTextField.text else { return }
        guard let description = descriptionOfItemTextView.text else { return }
        guard let ingredients = ingredientsOfItemTextView.text else { return }
        guard let price = priceTextField.text else { return }
        
        FirebaseStorageService.uploadManager.storeImage(image: self.imageToUpload!) { (result) in
            switch result {
            case .failure(let error):
                self.present(ShowAlert.prompt(with: "Could Not Upload Image", and: "\(error)"), animated: true, completion: nil)
            case .success(let url):
                
                let daysToAdd = 7
                var newDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: Date())
                //newDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: newDate!)
                print(newDate)
                
                let newItem = Item(name: nameOfItem,
                                   photoURL: url.absoluteString,
                                   description: description,
                                   userName: "TO-DO",
                                   userID: user.uid,
                                   ingredients: ingredients,
                                   price: Double(price)!,
                                   contributions: 0,
                                   priceForEachContributor: 5.00,
                                   dateCreated: Date(),
                                   endDate: newDate,
                                   contributors: [""])
                
                FirestoreService.manager.createPost(newItem: newItem) { (result) in
                    switch result {
                    case .failure(let error):
                        self.present(ShowAlert.prompt(with: "Could Not Create Post", and: "\(error)"), animated: true, completion: nil)
                        
                    case .success:
                        self.present(ShowAlert.prompt(with: "Success", and: "Your item was successfully added"), animated: true, completion: nil)
                        
                    }
                    
                    
                }
            }
            
            
            
            //        FirestoreService.manager.createPost(post: Post(photoUrl: photoUrl.absoluteString, creatorID: user.uid)) { (result) in
            //            self.uploadButton.isEnabled = false
            //
            //            switch result {
            //
            //            case .failure(let error):
            //                self.present(ShowAlert.showAlert(with: "Could not make post", and: "Error: \(error)"), animated: true, completion: nil)
            //
            //            case .success:
            //                self.present(ShowAlert.showAlert(with: "Success", and: "Post created"), animated: true, completion: nil)
            //                self.uploadImageView.image = UIImage(named: "uploadImage")
            //                self.uploadButton.isEnabled = true
            //                self.view.layoutSubviews()
            //            }
            //        }
            
            
            //TO-DO: ADD FIREBASE STORAGE SERVICE
            //FirebaseStorageService.profileManager.storeImage(image: imageData, completion: { [weak self] (result) in
            //switch result{
            //case .success(let url): return (self?.imageURL = url)!
            //case .failure(let error): print(error)
            //}
            //})
        }
        
        
    }
    
}

extension PostVC: UITextFieldDelegate {}

extension PostVC: UITextViewDelegate {}

extension PostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            present(ShowAlert.prompt(with: "Error", and: "Couldn't get image"), animated: true, completion: nil)
            return
        }
        
        self.itemImage.image = image
        self.imageToUpload = image.jpegData(compressionQuality: 0.4)
        
        dismiss(animated: true, completion: nil)
    }
}
