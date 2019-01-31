//
//  Pagar.swift
//  Mitexam2
//
//  Created by Joel Lozano on 1/29/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation
import UIKit
import Parse
import CoreLocation


class Pagar: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    
//    @IBOutlet var Tarjeta_Configurada: UILabel!
//    @IBOutlet var Tarjeta_Destinatario: UITextField!
//    @IBOutlet var Nombre_Destinatario: UITextField!
//    @IBOutlet var MotivoPago: UITextField!
//    
    
    @IBOutlet var Tarjeta_Configurada: UILabel!
    @IBOutlet var Tarjeta_Destinatario: UITextField!
    @IBOutlet var Nombre_Destinatario: UITextField!
    @IBOutlet var Motivo_Pago: UITextField!
    
    
    @IBAction func Boton_Pagar(_ sender: Any) {
        
        Tarjeta_Configurada.resignFirstResponder()
        Tarjeta_Destinatario.resignFirstResponder()
        Nombre_Destinatario.resignFirstResponder()
        Motivo_Pago.resignFirstResponder()
        
        
        do {
            
            // Manda el nombre del actual usuario
            let currentusernow =  PFUser.current()!
            let result = currentusernow.username
            
            
            
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: result!)
            let contact = try query.getFirstObject()
            print(contact)
            //create a new object
            let call = PFObject(className: "Movimientos")
            
            call["nombre"] = result!
             call["Usuario"] = contact
            call["TarjetaConfigurada"] = Tarjeta_Configurada.text
            call["TarjetaDestinatario"]  = Tarjeta_Destinatario.text
            call["NombreDestinatario"] = Nombre_Destinatario.text
            call["MotivodePago"] = Motivo_Pago.text
            call["Fecha"] = obtenerfecha()
            call["Coordenadas"] = "00000,00000"
            
            
            
            
            //save
            call.saveInBackground()
            
            
            
        }
            
        catch{
            //couldnt get the contact
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Tarjeta_Destinatario.delegate = self
        self.Nombre_Destinatario.delegate = self
        self.Motivo_Pago.delegate = self
        thePicker.delegate = self
        Motivo_Pago.inputView = thePicker
        let name = UserDefaults.standard.string(forKey: "Num_Tarjeta")
        
        Tarjeta_Configurada.text = name
        navigationController?.navigationBar.prefersLargeTitles = true
        //  Geolocalizacion
     
       
            
            
                    
            
            
            
            
            
        
            
        
        
        
        
        
    }
    

        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     let myPickerData = [String](arrayLiteral: "Agua", "Luz", "Telefono", "Gas","Otro")

    //protocolo del label picker obligatrio
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Motivo_Pago.text = myPickerData[row] as String
        print(Motivo_Pago.text!)
    }

    
    
    
    let datepick = UIDatePicker()
    let thePicker = UIPickerView()

    
    
    func obtenerfecha() -> String{
        let date = Date()
        
        print(date)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        print(dateFormatter.string(from: date))
        
        return dateFormatter.string(from: date) as String
    }
    
    
    
    
    
    
    
   
    
   
}

