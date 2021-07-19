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
var photoURLGlobal: URL?
var schoolGlobal: String!
var globalID: String?
var returnSchool:String?

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
    // MARK: - dataPull
    struct dataPull: Codable {
        let response: Response
    }

    // MARK: - Response
    struct Response: Codable {
        let cursor: Int
        let results: [Result]
        let remaining, count: Int
    }

    // MARK: - Result
    struct Result: Codable {
        let logo: String?
        let name, createdDate, createdBy, modifiedDate: String
        let id, type: String

        enum CodingKeys: String, CodingKey {
            case logo = "Logo"
            case name = "Name"
            case createdDate = "Created Date"
            case createdBy = "Created By"
            case modifiedDate = "Modified Date"
            case id = "_id"
            case type = "_type"
        }
    }
    
    
//    struct dataPull: Codable {
//        
//        let response: [results]
//        let cursor: Int
//        let remaining: Int
//        
//    }
//
//    struct results: Codable {
//        let Logo: String
//        let schoolName: String
//        
//
//    }
    
 
}

