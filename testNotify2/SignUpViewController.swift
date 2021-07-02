//
//  SignUpViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/5/21.
//

import UIKit
import iOSDropDown

class SignUpViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var SignUpEmail: UITextField!
    
    @IBOutlet weak var SignUpPass: UITextField!
    

    @IBOutlet weak var SchoolPicker: DropDown!
    
    var loginToken:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        SchoolPicker.optionArray = ["Bloom Academy", "Red Hill Academy", "Argonaut Elementary"]
        
        // Do any additional setup after loading the view.
        
        SignUpEmail.delegate = self
        SignUpPass.delegate = self
        
        SignUpEmail.tag = 1
        SignUpPass.tag = 2
        
        self.hideKeyboardWhenTappedAround() 

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
    
    
   
    @IBAction func btnSignUpPressed(_ sender: Any) {
    
    let token = "99479211236bf2cb4823f1330ce8fa7a"
//
        let authValue: String? = "Bearer \(token)"

        let loginUrl = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/signup_copy"
        let parameters = ["email": SignUpEmail.text ?? "" , "pass" : SignUpPass.text ?? "", "school": SchoolPicker.text ?? ""]
        let headers : HTTPHeaders  = ["Authorization": authValue ?? ""]
        
        AF.request(loginUrl,
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: headers,
                   interceptor: nil).responseJSON{  [weak self] response in
            
            print("***************",response.result)

            switch response.result {
                            case .success:
                                if let data = response.data {
                                    print(data)
                                    // Convert This in JSON
                                    do {
                                        let responseDecoded = try JSONDecoder().decode(APIResponse.self, from: data)
                                        print("%%%%%%%%%%%%%%%%%%%%")
                                        print("USER: HELP", responseDecoded.response.token)
                                        self?.loginToken = responseDecoded.response.token
                                        print(self?.loginToken ?? "")
                                        dateComponents.year = 1
                                        dateComponents.day = -1
                                        loginTokenGlobal = self?.loginToken
                                        expiration = Calendar.current.date(byAdding: dateComponents, to: currentDateAndTime)
                                        

                                    }catch let error as NSError{
                                        print(error)
                                    }
                                }
                            case .failure(let error):
                                print("Error:", error)
                            }
                    
//                    if string.value?.contains("success") ?? false
                    if ((self?.loginToken) != nil){
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(true, forKey: "didLogin")
             
                            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC") as! UITabBarController
                            guard let vc = tabbarVC.viewControllers![0] as? ViewController else {return}
                            vc.authToken = self?.SignUpEmail.text!
                            vc.passToken = self?.SignUpPass.text!
                            //vc.loginToken2 = self?.loginToken
                            UIApplication.shared.windows[0].rootViewController = tabbarVC
          
                        }
                    }
                    if ((self?.loginToken) == nil){
                        self?.shakeAnimation()
                        self?.SignUpEmail.text = ""
                        self?.SignUpPass.text = ""
                    }
       
        }
    }
}
