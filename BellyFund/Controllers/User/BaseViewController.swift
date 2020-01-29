//
//  BaseViewController.swift
//  BellyFund
//
//  Created by Alex 6.1 on 1/22/20.
//  Copyright © 2020 aglegaspi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
//    override func showAlert(title: String, message: String) {
//        <#code#>
//    }
    private var activityIndicator = UIActivityIndicatorView()
    func showSpinner() {
        activityIndicator.startAnimating()
    }
    
    func hideSpinner() {
        activityIndicator.stopAnimating()
    }
}
