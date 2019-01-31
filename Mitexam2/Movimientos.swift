//
//  Movimientos.swift
//  Mitexam2
//
//  Created by Joel Lozano on 1/30/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation
import UIKit
import Parse


class Movimientos: UIViewController,UITableViewDataSource ,UITableViewDelegate  {
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        return cell
    }
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        func userKcal(completion: ([String]) -> ()) {
//            let query = PFQuery(className: "Movimientos")
//            query.whereKey("userPointer", equalTo: PFUser.current()!)
//            query.findObjectsInBackground { (objects, error) in
//                if let returnedObjects = objects {
//                    for object in returnedObjects {
//                        let kcal = object["kcal"] as? String
//                        self.strings.append(kcal!)
//                    }
//                }
//                completion(self.strings)
//            }
//        }


    }
    
    
}



