//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 11/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUserName = "This username created and invalid request"
    case unableToComplete = "Unable to complete your request. Please check your Internet"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "Data recieved from server was invalid"
    
}
