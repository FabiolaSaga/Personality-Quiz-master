//
//  LoginViewController.swift
//  PersonalityQuiz
//
//  Created by Fabiola Saga on 2/28/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit


// This should probably be in a scroll view. On an SE, we cannot both type and see the text fields.

// Might aslo make sense to add "return" button handler for the keyboard to either dismiss the keyboard, or move to next field/submit.
extension UIViewController {
  
  // funcs generally have lower-case names
  
  // name might be misleading. This doesn't hide the keyboard. It sets up a gesture recognizer.
    func HideKeyboard() {
      // variabels generally have lower-case names.
        let Tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
    }
  
  // lowercase funcs
    @objc func DismissKeyboard() {
        
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // This might not do anything? Is the keyboard displayed when this view is loaded?
        self.HideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginAction(_ sender: Any) {
      // "!" are dangerous. `guard` is a better alternative:
      /*
       guard let someEmail = email.text,
             let somePassword = password.text else {
         return //or throw an error?
       }
       Auth.auth().signIn(withEmail: someEmail, password: somePassword) ...
       */
      Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
        // consider switch to make sure all cases are handled:
        /*
         switch (user, error) {
         case (_, let e?):
           // present error...
         case (let user?, nil):
           performSegue(withIdentifier: "loginToHome", sender: self)
         case (nil, nil):
           // this case isn't currently handled. We should probably display an error or something
         }
         */
            if error == nil{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else{
              // This type of alert is created a few times. Maybe extract?
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func facebookLogin(sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
          // Like above, a switch would help catch unexpected possibilities.
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
          // above, this is done with trailing closure syntax. Why different here?
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present the main view
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                  // This probably doesn't work as expected. "MainView" is a `HomeViewController`, not a navigation controller.
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                  // What are we dismissing here?
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
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
