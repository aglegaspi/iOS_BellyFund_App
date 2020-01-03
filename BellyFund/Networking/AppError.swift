//
//  AppError.swift
//  BellyFund
//
//  Created by Alex 6.1 on 12/17/19.
//  Copyright © 2019 aglegaspi. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
