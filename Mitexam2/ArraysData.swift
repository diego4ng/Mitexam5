//
//  ArraysData.swift
//  Mitexam2
//
//  Created by Joel Lozano on 1/30/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

//

import Foundation
import UIKit
import Parse

class ArrayData{
    //Se crea un Array para guardar los datos y despues mostrarlos en la tabla 
    var FechaArray: [String] = []
    
    init() {
        
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
                    }}}})
        
        
    }
}
