//
//  Cookie.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/22/21.
//


import UIKit
import WebKit


var loginTokenGlobal: String?
var loginEmailGlobal: String?
var loginPassGlobal: String?
var tokenExpireGlobal: Int?
var expiration: Date?

var currentDateAndTime = Date()
var dateComponents = DateComponents()

let calendar = Calendar.current




extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    struct APIResponse: Codable {
        
        let response: result
        let status: String
    }

    struct result: Codable {
        let token: String
        let expires: Int
        let user_id: String
       
    }
    
    
    
    
    
}

