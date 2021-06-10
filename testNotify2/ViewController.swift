//
//  ViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/5/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    func btnPush (){
        let vc = storyboard?.instantiateViewController(identifier: "starterPage") as! LoginViewController
        //vc.modalPresentationStyle = .fullScreen
        vc.completionHandler = { text in
            self.label.text = text
        }
        present(vc, animated: true)
        
        
    }
    
    
    @IBOutlet weak var label: UILabel!

    @IBAction func btnLogOut(_ sender: Any) {

        let token = "99479211236bf2cb4823f1330ce8fa7a"
        let authValue2: String? = "Bearer \(token)"
        let loginUrl2 = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/logout"
        //let parameters = [""]
        let headers : HTTPHeaders  = ["Authorization": authValue2 ?? ""]
        // All three of these calls are equivalent
        
        AF.request(loginUrl2, method: .post,  headers: headers, interceptor: nil).responseString { (string) in
            //print(string)
            
            if string.value?.contains("logout") ?? false{
                
                
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
        // Do any additional setup after loading the view.
        webview.load(URLRequest(url: URL(string: "https://schoolnotifier.bubbleapps.io/version-test")!))
        //          webview.scrollView.isScrollEnabled = false
        
        let vc2 = storyboard?.instantiateViewController(identifier: "starterPage") as! LoginViewController
        vc2.modalPresentationStyle = .fullScreen
        vc2.completionHandler = { text in
            self.label.text = text
        }
        present(vc2, animated: true)
        
        
        
        
        
    }

}
