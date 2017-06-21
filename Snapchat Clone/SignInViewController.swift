//
//  SignInViewController.swift
//  Snapchat Clone
//
//  Created by Matthew Oh on 6/9/17.
//  Copyright © 2017 BB Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FBSDKLoginKit

class SignInViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.center = view.center
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        } else {
            print("Successfully logged in with Facebook")
        }
    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            print("We tried to sign in")
            if error != nil {
                print("We have an error:\(error)")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    
                    print("We tried to create a user")
                    if error != nil {
                        print("We have an error:\(error)")
                    } else {
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
                
            } else {
                print("Sign in success")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        }
    }
    
}




