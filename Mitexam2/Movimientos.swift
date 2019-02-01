//
//  Movimientos.swift
//  Mitexam2
//
//  Created by Diego Fernandez on 31/01/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation
import UIKit
import Parse


class Movimientos: UIViewController,UITableViewDataSource ,UITableViewDelegate  {
   
    var FechaArray: [String] = []
    var MotivodepagoArray: [String] = []
    var NombreDestArray: [String] = []
    var TarjetaConfArray: [String] = []
    var TarjetaDestArray: [String] = []
    var coordenadasArray: [String] = []
    
    
    @IBOutlet weak var movimientos_table: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  self.FechaArray.count == self.MotivodepagoArray.count &&
            self.FechaArray.count == self.NombreDestArray.count &&
            self.FechaArray.count == self.TarjetaDestArray.count &&
            self.FechaArray.count == self.coordenadasArray.count &&
            self.FechaArray.count == self.TarjetaConfArray.count{
       return FechaArray.count
        } else {
            //self.movimientos_table.reloadData()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:tablecell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tablecell
        
     let fecha = self.FechaArray[indexPath.row]
     let motivo = self.MotivodepagoArray[indexPath.row]
     let nombred = self.NombreDestArray[indexPath.row]
    let tarjetad = self.TarjetaDestArray[indexPath.row]
        let tarjetaconf = self.TarjetaConfArray[indexPath.row]
        let corde = self.coordenadasArray[indexPath.row]
//
        cell.cell_Fecha.text = fecha
        cell.cell_MotivodePago.text = motivo
        cell.cell_NombreDestinatario.text = nombred
        cell.cell_TarjetaDestinatario.text = tarjetad
        cell.cell_tarjetaconfigurada.text = tarjetaconf
        cell.cell_coordenadas.text = corde
        
   
        
        return cell
    }
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        retrieveFecha()
        retrieveMotivoPago()
        retrieveNombreDest()
        retrieveTarjetaDest()
        retrieveCoordenadas()
        retrieveTarjetaConf()
self.movimientos_table.reloadData()

    }
//Obtiene la fecha de Back4app
 ////////////////////////////////////////////////////////////////////////////////////
    func retrieveFecha() {
        
        let query = PFQuery(className: "Movimientos")
        query.whereKey("nombre", equalTo: (PFUser.current()?.username!)!)
        query.findObjectsInBackground(block: { (objects, error) in
            if error == nil{
                //no hay errot
                if let returnedobjects = objects {
                    
                    for object in returnedobjects{
                        self.FechaArray.append(object["Fecha"] as! String)
                        print(object["Fecha"] as! String)
                        print(self.FechaArray)
                        print(self.FechaArray.count)
                    }
                }
                self.movimientos_table.reloadData()
            }})
}
   // Obtiene la Motivo de Pago de Back4app
////////////////////////////////////////////////////////////////////////////////////
    func retrieveMotivoPago() {
        let query = PFQuery(className: "Movimientos")
        query.whereKey("nombre", equalTo: (PFUser.current()?.username!)!)
        query.findObjectsInBackground(block: { (objects, error) in
            if error == nil{
                //no hay errot
                if let returnedobjects = objects {

                    for object in returnedobjects{
                        self.MotivodepagoArray.append(object["MotivodePago"] as! String)
                        print(object["MotivodePago"] as! String)
                        print(self.MotivodepagoArray)
                        print(self.MotivodepagoArray.count)
                    }
                }
                self.movimientos_table.reloadData()
            }})
    }
 //   Obtiene el Nombre Destinatario de Back4app
////////////////////////////////////////////////////////////////////////////////////
        func retrieveNombreDest() {
            let query = PFQuery(className: "Movimientos")
            query.whereKey("nombre", equalTo: (PFUser.current()?.username!)!)
            query.findObjectsInBackground(block: { (objects, error) in
                if error == nil{
                    //no hay errot
                    if let returnedobjects = objects {

                        for object in returnedobjects{
                            self.NombreDestArray.append(object["NombreDestinatario"] as! String)
                            print(object["NombreDestinatario"] as! String)
                            print(self.NombreDestArray)
                            print(self.NombreDestArray.count)
                        }
                    }
                    self.movimientos_table.reloadData()
                }})
        }
//   Obtiene el Tarjeta Destinatario de Back4app
////////////////////////////////////////////////////////////////////////////////////
    
    func retrieveTarjetaDest() {
        
        let query = PFQuery(className: "Movimientos")
        query.whereKey("nombre", equalTo: (PFUser.current()?.username!)!)
        query.findObjectsInBackground(block: { (objects, error) in

            if error == nil{
                //no hay errot
                if let returnedobjects = objects {

                    for object in returnedobjects{
                        self.TarjetaConfArray.append(object["TarjetaConfigurada"] as! String)
                        print(object["TarjetaConfigurada"] as! String)

                    }

                }
                self.movimientos_table.reloadData()
            }})
  }
 //   Obtiene el Nombre Destinatario de Back4app
    
    func retrieveTarjetaConf() {
        
        let query = PFQuery(className: "Movimientos")
        query.whereKey("nombre", equalTo: (PFUser.current()?.username!)!)
        query.findObjectsInBackground(block: { (objects, error) in

            if error == nil{
                //no hay errot
                if let returnedobjects = objects {

                    for object in returnedobjects{
                        self.TarjetaDestArray.append(object["TarjetaDestinatario"] as! String)
                        print(object["TarjetaDestinatario"] as! String)

                    }

                }
                self.movimientos_table.reloadData()
            }})


    }
    
    //   Obtiene el Nombre Coordenadas de Back4app
    
    func retrieveCoordenadas() {
        
        let query = PFQuery(className: "Movimientos")
        query.whereKey("nombre", equalTo: (PFUser.current()?.username!)!)
        query.findObjectsInBackground(block: { (objects, error) in
            
            if error == nil{
                //no hay errot
                if let returnedobjects = objects {
                    
                    for object in returnedobjects{
                        self.coordenadasArray.append(object["Coordenadas"] as! String)
                        print(object["Coordenadas"] as! String)
                        
                    }
                    
                }
                self.movimientos_table.reloadData()
            }})
        
        
    }
   

}
