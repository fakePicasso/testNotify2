//
//  LoginViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/5/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var LoginEmail: UITextField!
    @IBOutlet weak var LoginPass: UITextField!
    
    public var completionHandler: ((String?)-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        LoginEmail.delegate = self
        LoginPass.delegate = self
        
        LoginEmail.tag = 1
        LoginPass.tag = 2
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
            if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return false
        }

    
    //@IBAction func btnLoginPressed(_ sender: Any) {
    @IBAction func btnLoginPressed(_ sender: Any, forEvent event: UIEvent) {

        //dismiss(animated: true, completion: nil)
        let token = "99479211236bf2cb4823f1330ce8fa7a"
        let authValue: String? = "Bearer \(token)"
        let loginUrl = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/login_copy"
        let parameters = ["email": LoginEmail.text ?? "" , "pass" : LoginPass.text ?? ""]
        let headers : HTTPHeaders  = ["Authorization": authValue ?? ""]

        completionHandler?(LoginEmail.text)

        // All three of these calls are equivalent
        AF.request(loginUrl, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { (string) in
            
            if string.value?.contains("success") ?? false{
                
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "didLogin")
                    
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TabbarVC") as! UITabBarController
                    UIApplication.shared.windows[0].rootViewController = vc
  
                }
                
            }
            
        }
        
    }
    //*****
    @IBAction func testBtn(_ sender: Any, forEvent event: UIEvent) {
        
        let vc = storyboard?.instantiateViewController(identifier: "other") as! ViewController
        //vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
        completionHandler?(LoginEmail.text)
        
        
        //dismiss(animated: true, completion: nil)
    }
    
}
