//
//  MainTBC.swift
//  BellyFund
//
//  Created by Alex 6.1 on 12/16/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import UIKit

class MainTBC: UITabBarController {
    lazy var feedVC = UINavigationController(rootViewController: FeedVC())
    lazy var postVC = UINavigationController(rootViewController: PostVC())
    lazy var profileVC: UINavigationController = {
        let userProfileVC = ProfileVC()
        return UINavigationController(rootViewController: userProfileVC)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedVC.isNavigationBarHidden = true
        postVC.isNavigationBarHidden = true
        profileVC.isNavigationBarHidden = true
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.dash"), tag: 0)
        postVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "photo"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 2)
        self.viewControllers = [feedVC, postVC, profileVC]
        self.viewControllers?.forEach({$0.tabBarController?.tabBar.barStyle = .default})
    }
    
}
