//
//  APIUIViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 7/2/21.
//

import UIKit
import Foundation


class APIUIViewController: UIViewController {
    var schoolHelper: String?

    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myImage2: UIImageView!

    var LogoURL: String?
    var LogoURL2: URL?
    var LogoURL3: URL?

    
    var school: String?
    var schoolURL: String?

    
    var dictionary2: [AnyHashable: Any] = [
        "constraints": ["key":"Name", "constraint_type": "text contains", "value": "Argonaut"]
    ]

    
    //THIS ONE IS WORKING AS LITERAL BUT NOT VARIABLE
    
    var dictionary3 = [
        "constraints": [URLQueryItem(name: "key", value: "Name"),
                        URLQueryItem(name: "constraint_type", value: "text contains"),
                        URLQueryItem(name: "value", value: "Argonaut")]
        
    ]

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
        let id: String

        enum CodingKeys: String, CodingKey {
            case logo = "Logo"
            case name = "Name"
            case createdDate = "Created Date"
            case createdBy = "Created By"
            case modifiedDate = "Modified Date"
            case id = "_id"
            //case type = "_type"
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhotos()
        getUser()
        print(school as Any)
        findRepositories()
        getUserData()
        emailLabel.text = loginEmailGlobal
        
//        if (schoolLabel.text != nil) {
//            findRepositories(school: schoolLabel.text!)
//        }
        

    }

    
    func fetchPhotos() {

        let urlString = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/obj/school"
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data,_, error in
            guard let data = data, error == nil else {
                return
            }
            print("Got data!!")
            print(data.count)

            do{
                let jsonResult = try JSONDecoder().decode(dataPull.self, from: data)
//                print(jsonResult.response.results[0].logo)
                DispatchQueue.main.async { [self] in
//                    self?.results = jsonResult.results
//                    self?.collectionView?.reloadData()
                    self?.LogoURL = jsonResult.response.results[0].logo
                    print(self?.LogoURL ?? "")
                    self?.LogoURL = self?.LogoURL?.replacingOccurrences(of: "//", with: "https://")
                    let imageurl = URL(string: self?.LogoURL ?? "")!

                        // Fetch Image Data
                        if let data = try? Data(contentsOf: imageurl) {
                            // Create Image and Update Image View
                            self?.myImage.image = UIImage(data: data)
                        }
                }
            }
            catch{
                print(error)
            }

        }
        task.resume()
    }
    
    func getUser(){
        
        //var returnSchool: String?
        let Btoken = "99479211236bf2cb4823f1330ce8fa7a"
        let authValue: String? = "Bearer \(Btoken)"
        let urlAPI = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/current_user"
        
        let headers : HTTPHeaders  = ["Authorization": authValue ?? ""]
        let parameters = ["email": loginEmailGlobal]
        
        AF.request(urlAPI, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { [self] (string2) in
            print(string2)
            self.school = string2.result.success
            schoolLabel.text = school
            schoolGlobal = school
            print(schoolGlobal as Any)
//            findRepositories()
            schoolURL = school
            schoolHelper = schoolLabel.text

        }
    }

    
    func findRepositories() {
        var components = URLComponents()
        
//        let queryItems = dictionary.map{
//            return URLQueryItem(name: "\($0)", value: "\($1)")
//        }
        
        
//        dictionary2.updateValue(["key":"Name", "constraint_type": "text contains", "value": schoolLabel.text], forKey: "constraints")
//        print(dictionary2)
        
        components.scheme = "https"
        components.host = "schoolnotifier.bubbleapps.io"
        components.path = "/version-test/api/1.1/obj/school"
        components.queryItems = dictionary2.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }

        // Getting a URL from our components is as simple as
        // accessing the 'url' property.
        let url = components.url
        LogoURL2 = url
        
        func urlHelper(url2: URL){
            
            if (url2.absoluteString.contains("%5B")) {
                let url3 = url2.absoluteString
                if url3.contains("%5B") {
                    let url4 = url3.replacingOccurrences(of: "%5B", with: "%5B%7B")
                    print(url4)
                    let url5 = url4.replacingOccurrences(of: "%22%5D", with: "%22%7D%5D")
                    print(url5)
                    
                    LogoURL3 = URL(string: url5)
                    
                }
            }
        }
        urlHelper(url2: LogoURL2!)

    }

//    func findRepositories(school: String) {
//        var components = URLComponents()
//
////        let queryItems = dictionary.map{
////            return URLQueryItem(name: "\($0)", value: "\($1)")
////        }
//
//
//        //dictionary2.updateValue(["key":"Name", "constraint_type": "text contains", "value": schoolHelper], forKey: "constraints")
//
//        components.scheme = "https"
//        components.host = "schoolnotifier.bubbleapps.io"
//        components.path = "/version-test/api/1.1/obj/school"
//        components.queryItems = dictionary2.map{
//            return URLQueryItem(name: "\($0)", value: "\($1)")
//        }
//
//        // Getting a URL from our components is as simple as
//        // accessing the 'url' property.
//        let url = components.url
//        LogoURL2 = url
//
//        func urlHelper(url2: URL){
//
//            if (url2.absoluteString.contains("%5B")) {
//                let url3 = url2.absoluteString
//                if url3.contains("%5B") {
//                    let url4 = url3.replacingOccurrences(of: "%5B", with: "%5B%7B")
//                    print(url4)
//                    let url5 = url4.replacingOccurrences(of: "%22%5D", with: "%22%7D%5D")
//                    print(url5)
//
//                    LogoURL3 = URL(string: url5)
//
//                }
//            }
//        }
//        urlHelper(url2: LogoURL2!)
//        getUserData()
//
//    }
    
    func getUserData(){
        

        let task2 = URLSession.shared.dataTask(with: LogoURL3!) { [weak self] data,_, error in
            guard let data = data, error == nil else {
                return
            }
            print("Got data from getUserData()")
            print(data.count)
            print(self?.LogoURL3)
            
            do{
                let jsonResult = try JSONDecoder().decode(dataPull.self, from: data)
                //print(jsonResult.response.results.)
                DispatchQueue.main.async { [self] in
//                    self?.results = jsonResult.results
//                    self?.collectionView?.reloadData()
                    self?.LogoURL = jsonResult.response.results[0].logo
                    
                    print(self?.LogoURL ?? "")
                    self?.LogoURL = self?.LogoURL?.replacingOccurrences(of: "//", with: "https://")
                    let imageurl = URL(string: self?.LogoURL ?? "")!

                        // Fetch Image Data
                        if let data = try? Data(contentsOf: imageurl) {
                            // Create Image and Update Image View
                            self?.myImage2.image = UIImage(data: data)
                        }
                    print("HERE!!!!!!!!!!!!!!!!!!!!!!!!")
                }
            }
            catch{
                print(error)
            }
        }
        task2.resume()
    }
    
}
