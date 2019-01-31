//
//  ViewController.swift
//  Mitexam2
//
//  Created by Joel Lozano on 1/28/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController,UITextFieldDelegate {

    
   

    @IBOutlet var UserIngresar: UITextField!
    
    @IBOutlet var PasswordIngresar: UITextField!
    @IBOutlet var UserRegistro: UITextField!
    @IBOutlet var PasswordRgistro: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserIngresar.text = ""
        PasswordIngresar.text = ""
        UserRegistro.text = ""
        PasswordRgistro.text = ""
        
        
        self.UserIngresar.delegate = self
        self.PasswordIngresar.delegate = self
        self.UserRegistro.delegate = self
        self.PasswordRgistro.delegate = self
    }
    
    @IBAction func IniciaSesion(_ sender: UIButton) {
        
        UserIngresar.resignFirstResponder()
        PasswordIngresar.resignFirstResponder()
        let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logInWithUsername(inBackground: UserIngresar.text!, password: PasswordIngresar.text!) { (user, error) in
            UIViewController.removeSpinner(spinner: sv)
            if user != nil {
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: (descrip))
                }
            }
        }
    }
    
    @IBAction func Registro(_ sender: UIButton) {
        
        UserRegistro.resignFirstResponder()
        PasswordRgistro.resignFirstResponder()
        
        let user = PFUser()
        user.username = UserRegistro.text
        user.password = PasswordRgistro.text
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        user.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            if success{
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }
            }
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadHomeScreen()
        }
    }
    
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  

    
    }



extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
