//
//  SignUpViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/5/21.
//

import UIKit
import iOSDropDown

class SignUpViewController: UIViewController {


    @IBOutlet weak var SignUpEmail: UITextField!
    
    @IBOutlet weak var SignUpPass: UITextField!
    

    @IBOutlet weak var SchoolPicker: DropDown!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchoolPicker.optionArray = ["Bloom Academy", "Red Hill Academy", "Argonaut Elementary"]
        
        // Do any additional setup after loading the view.
    }
    
    func shakeAnimation() {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.2
            animation.repeatCount = 2
            animation.speed = 5
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.view.center.x - 10, y:  self.view.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.view.center.x + 10, y:  self.view.center.y))
            self.view.layer.add(animation, forKey: "position")
        }
    
    
    //@IBAction func btnLoginPressed(_ sender: Any) {
    @IBAction func btnSignUpPressed(_ sender: Any) {
    
    let token = "99479211236bf2cb4823f1330ce8fa7a"
//
        let authValue: String? = "Bearer \(token)"

        let loginUrl = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/signup"
        let parameters = ["email": SignUpEmail.text ?? "" , "pass" : SignUpPass.text ?? "", "school": SchoolPicker.text ?? ""]
        let headers : HTTPHeaders  = ["Authorization": authValue ?? ""]
        // All three of these calls are equivalent
        AF.request(loginUrl, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { (string) in
            //print(string)
            if string.value?.contains("signup") ?? false{
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "didLogin")
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TabbarVC") as! UITabBarController
                    UIApplication.shared.windows[0].rootViewController = vc
                }
                
            }
            
            
            if ((string.value?.isEmpty) != nil){
                
                self.shakeAnimation()
                self.SignUpEmail.text = ""
                self.SignUpPass.text = ""
            }
            
        }
        
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
