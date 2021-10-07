//
//  ForgetViewController.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/7/21.
//

import UIKit

class ForgetViewController: UIViewController {

    @IBOutlet weak var forgetEmail: UITextField!
    
    @IBAction func btnPressedForget(_ sender: Any) {
        let token = "99479211236bf2cb4823f1330ce8fa7a"
    //
            let authValue: String? = "Bearer \(token)"

            let loginUrl = "https://schoolnotifier.bubbleapps.io/version-test/api/1.1/wf/forget"
            let parameters = ["email": forgetEmail.text ?? ""]
            let headers : HTTPHeaders  = ["Authorization": authValue ?? ""]
            // All three of these calls are equivalent
            AF.request(loginUrl, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).responseString { (string) in
                //print(string)
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                       let vc = storyboard.instantiateViewController(withIdentifier: "starterPage")
                                        UIApplication.shared.windows[0].rootViewController = vc
                
            }
            
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround() 
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
