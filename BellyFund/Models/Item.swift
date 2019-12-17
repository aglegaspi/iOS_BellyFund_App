//
//  Item.swift
//  BellyFund
//
//  Created by Alex 6.1 on 12/16/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//
import Foundation
import FirebaseFirestore

struct Item {
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
    
    init(name: String,
         photoURL: String,
         description: String,
         userName: String,
         userID: String,
         ingredients: String,
         price: Double,
         contributions: Int = 0,
         priceForEachContributor: Double = 5.00,
         dateCreated: Date? = nil,
         endDate: Date? = nil,
         contributors: [String]) {
            self.name = name
            self.photoURL = photoURL
            self.description = description
            self.userName = userName
            self.userID = userID
            self.ingredients = ingredients
            self.price = price
            self.contributions = contributions
            self.priceForEachContributor = priceForEachContributor
            self.itemID = UUID().description
            self.dateCreated = dateCreated
            self.endDate = endDate
            self.contributors = contributors
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let name = dict["name"] as? String,
            let photoURL = dict["photoURL"] as? String,
            let description = dict["description"] as? String,
            let userName = dict["userName"] as? String,
            let userID = dict["userID"] as? String,
            let ingredients = dict["ingredients"] as? String,
            let price = dict["price"] as? Double,
            let contributions = dict["contributions"] as? Int,
            let priceForEachContributor = dict["priceForEachContributor"] as? Double,
            let itemID = dict["itemID"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
            let endDate = dict["endDate"] as? Date?,
            let contributors = dict["contributors"] as? [String] else { return nil }
        
        self.name = name
        self.photoURL = photoURL
        self.description = description
        self.userName = userName
        self.userID = userID
        self.ingredients = ingredients
        self.price = price
        self.contributions = contributions
        self.priceForEachContributor = priceForEachContributor
        self.itemID = itemID
        self.dateCreated = dateCreated
        self.endDate = endDate
        self.contributors = contributors
    }
    
    var fieldsDict: [String: Any] {
        return [
            "name": self.name ?? "",
            "photoURL": self.photoURL ?? "",
            "description": self.description ?? "",
            "userName": self.userName ?? "",
            "userID": self.userID ?? "",
            "ingredients": self.ingredients ?? "",
            "price": self.price ?? 0.00,
            "contributions": self.contributions ?? 0,
            "priceForEachContributor": self.priceForEachContributor ?? 5.00,
            "itemID": self.itemID ?? "",
            "dateCreated": self.dateCreated ?? "",
            "endDate": self.endDate ?? "",
            "constributors": self.contributors ?? ""
        ]
    }
}
