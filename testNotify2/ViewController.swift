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
    var loginToken2: String?
    
    var completionHandler: ((String?) -> Void)?
    
    func btnPush (){
        let vc = storyboard?.instantiateViewController(identifier: "starterPage") as! LoginViewController
        //vc.modalPresentationStyle = .fullScreen
//        vc.completionHandler = { text in
//            self.label.text = text
//        }
        present(vc, animated: true)
    }
    
    
    @IBOutlet weak var label: UILabel!

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
    
    @IBOutlet weak var webview: WKWebView!

    
    
    override func viewDidLoad() {
   
        
        //UIApplication.shared.windows[0].rootViewController = vc
        super.viewDidLoad()
        let vc2 = storyboard?.instantiateViewController(identifier: "starterPage") as! LoginViewController
        vc2.modalPresentationStyle = .fullScreen

        self.label.text = self.authToken
        //vc2.loginToken = URLToken
       
        
        
        present(vc2, animated: true)
        // *************** //
        print(loginToken2)
        // Do any additional setup after loading the view.
        webview.load(URLRequest(url: URL(string: "https://schoolnotifier.bubbleapps.io/version-test/test2?access_token=\(loginToken2 ?? "")")!))
        //testWebCookie()
        //          webview.scrollView.isScrollEnabled = false
        
        //********NEW TEST AUTH CODE
//        let token = "99479211236bf2cb4823f1330ce8fa7a"
//        let authValue2: String? = "Bearer \(token)"
//        let loginUrl2 = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/login_copy"
//        let parameters = ["email": authToken ?? "" , "pass" : passToken ?? "" ]
//        let headers : HTTPHeaders  = ["Authorization": authValue2 ?? ""]
//        // All three of these calls are equivalent
//
//        AF.request(loginUrl2, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { (string) in
//            print(string)
//        }

        
        
        
        
        
        
    }

}
