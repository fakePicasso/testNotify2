//
//  NotificationsViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/30/21.
//

import UIKit
import WebKit

class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var webviewNotification: WKWebView!
    
    var loginToken: String?
    
    var loginToken2: String?
    var loginToken3: String?
    
    
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webviewNotification.load(URLRequest(url: URL(string: "https://schoolnotifier.bubbleapps.io/version-test/notifications?access_token=\(loginTokenGlobal ?? "")")!))
        loadViewIfNeeded()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
