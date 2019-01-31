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
   
    
    var todoList: ArrayData
    
    required init?(coder aDecoder: NSCoder) {
        todoList = ArrayData()
        super.init(coder: aDecoder)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       return todoList.FechaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:tablecell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tablecell
        
//       let fecha = todoList.FechaArray[indexPath.row]
//       cell = fecha.text
        
        
        return cell
    }
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        
        
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



