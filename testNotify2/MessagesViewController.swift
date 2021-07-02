//
//  MessagesViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/30/21.
//

import UIKit
import WebKit

class MessagesViewController: UIViewController {
    
    
    
    @IBOutlet weak var webViewMessages: WKWebView!
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

    override func viewDidLoad() {
        super.viewDidLoad()

        webViewMessages.load(URLRequest(url: URL(string: "https://schoolnotifier.bubbleapps.io/version-test/messages?access_token=\(loginTokenGlobal ?? "")")!))
        loadViewIfNeeded()
    }
}
