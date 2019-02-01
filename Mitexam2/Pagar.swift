//
//  Pagar.swift
//  Mitexam2
//
//  Created by Diego Fernandez on 31/01/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation
import UIKit
import Parse
import CoreLocation
import MapKit


class Pagar: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    
    var region =  MKCoordinateRegion()
    var manager = CLLocationManager()
    var latitud : CLLocationDegrees!
    var longitud : CLLocationDegrees!
    
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
        
       // Oculta los campos cuando tocamos cualquier parte de la pantalla
        Tarjeta_Configurada.resignFirstResponder()
        Tarjeta_Destinatario.resignFirstResponder()
        Nombre_Destinatario.resignFirstResponder()
        Motivo_Pago.resignFirstResponder()
        
        
       // Manda la alerta cuando el campo es menor a 20 caracteres
        var tarjetadest1 = Tarjeta_Destinatario.text
        if (tarjetadest1?.characters.count)! <= 14 {
            let alertController = UIAlertController(title: "Atención", message: "Numero de Tarjeta Destinatario Incompleto", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed default");
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        } else{
        
        
        
        // Guarda las coordenadas de donde se realizo la compra
        let textocoordenadas = "lat: \(latitud!) \n & long: \(longitud!)"
        let localizacion = CLLocationCoordinate2DMake(latitud, longitud)
        let span = MKCoordinateSpan(latitudeDelta: 0.00110, longitudeDelta: 0.010)
        _ = MKCoordinateRegion(center: localizacion, span: span)
        
        
        do {
            
            // Manda el nombre del actual usuario
            let currentusernow =  PFUser.current()!
            let result = currentusernow.username
            
            
            // Guarda en la Clase Movimientos , los siguientes atributos
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
            call["Coordenadas"] = textocoordenadas
            //save
            call.saveInBackground()
        }         catch{}
        
            
            let alertController2 = UIAlertController(title: "Exitoso", message: "Pago completado", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Aceptar", style: .cancel) { (action:UIAlertAction) in
                print("You've pressed default")
                self.loadHomeScreen();
            }
            alertController2.addAction(action1)
            self.present(alertController2, animated: true, completion: nil)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            self.latitud = location.coordinate.latitude
            self.longitud = location.coordinate.longitude
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
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
     let myPickerData = [String](arrayLiteral: "Agua", "Luz","Telefono","Renta","Colegiatuta", "Gas","Otro")

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
    
    
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        self.present(loggedInViewController, animated: true, completion: nil)
    }
}


