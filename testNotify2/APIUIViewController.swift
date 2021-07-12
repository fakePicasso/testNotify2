//
//  APIUIViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 7/2/21.
//

import UIKit

class APIUIViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    var LogoURL: String?
    
    var school: String?
    
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
//            case type = "_type"
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        getUser()
        emailLabel.text = loginEmailGlobal
    


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
    
    func getUser() {
        let Btoken = "99479211236bf2cb4823f1330ce8fa7a"
        let authValue: String? = "Bearer \(Btoken)"
        let urlAPI = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/current_user"
        
        let headers : HTTPHeaders  = ["Authorization": authValue ?? ""]
        let parameters = ["email": "a@a.com"]
        
        AF.request(urlAPI, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { [self] (string2) in
            print(string2)
            self.school = string2.result.success
            print(string2.result.success)
            print(school!)
            schoolGlobal = self.school
            print(schoolGlobal)
            schoolLabel.text = school
            
            
            
            
        }
        
    }


}
