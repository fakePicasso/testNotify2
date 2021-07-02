//
//  ViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/5/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var authToken: String?
    var passToken: String?
    var email: String?
    var password: String?
    
    
  
    override func loadViewIfNeeded() {
        if loginTokenGlobal == nil || expiration! < currentDateAndTime {
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: "didLogin")
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "starterPage") as! LoginViewController
                UIApplication.shared.windows[0].rootViewController = vc
            }
        }
    }
    
    


   
    
    @IBOutlet weak var webview: WKWebView!

    
    
    override func viewDidLoad() {

        super.viewDidLoad()

        webview.load(URLRequest(url: URL(string: "https://schoolnotifier.bubbleapps.io/version-test/index?access_token=\(loginTokenGlobal ?? "")")!))
        loadViewIfNeeded()
    }
    @IBAction func btnLogOut(_ sender: Any) {

        let token = "99479211236bf2cb4823f1330ce8fa7a"
        let authValue2: String? = "Bearer \(token)"
        let loginUrl2 = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/logout"
        //let parameters = ["email": authToken ?? "" , "pass" : "a" ]
        let headers : HTTPHeaders  = ["Authorization": authValue2 ?? ""]
        // All three of these calls are equivalent
        
        AF.request(loginUrl2, method: .post,  headers: headers, interceptor: nil).responseString { (string) in
            //print(string)
            
            if string.value?.contains("logout") ?? false {

                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "didLogin")
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "starterPage") as! LoginViewController
                    UIApplication.shared.windows[0].rootViewController = vc
                }
            }
        }
    }

}
