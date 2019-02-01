//
//  MisTatjetas.swift
//  Mitexam2
//
//  Created by Diego Fernandez on 31/01/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Parse


class MisTarjetas: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var NombreCompleto: UITextField!
    @IBOutlet var NumTarjeta: UITextField!
    @IBOutlet var FechaExp: UITextField!
    
    
    
    @IBAction func SaveTarjeta(_ sender: UIButton) {
        
        if NombreCompleto.text == "" || NumTarjeta.text == "" || FechaExp.text == "" {
            let alertController = UIAlertController(title: "Atención", message: "Dejaste un Campo Vacio", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
        var cuentacharacter = NumTarjeta.text
        if (cuentacharacter?.characters.count)! <= 20 {
            let alertController = UIAlertController(title: "Atención", message: "Numero de Tarjeta Incompleto", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            
            
            
            print("falta taxto")
        }
        NombreCompleto.resignFirstResponder()
        NumTarjeta.resignFirstResponder()
        FechaExp.resignFirstResponder()

        do {
            
            
            
            let currentusernow =  PFUser.current()!
            let result = currentusernow.username
            

           
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: result!)
            let contact = try query.getFirstObject()
            print(contact)
            //create a new object
            let call = PFObject(className: "tarjetavalue")
            
            call["contact"] = contact
            call["NumTarjeta"]  = NumTarjeta.text
            call["NombreCompleto"] = NombreCompleto.text
            call["FechaExp"] = FechaExp.text
            
            
            //save
            call.saveInBackground()
            
            
            
        }
            
        catch{
            //couldnt get the contact
        }
        
        UserDefaults.standard.set(NumTarjeta.text, forKey: "Num_Tarjeta")
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
      self.NombreCompleto.delegate = self
        self.NumTarjeta.delegate = self
        self.FechaExp.delegate = self
        
        
        
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




