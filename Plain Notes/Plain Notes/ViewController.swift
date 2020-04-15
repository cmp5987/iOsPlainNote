//
//  ViewController.swift
//  Plain Notes
//
//  Created by catie on 4/15/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {


    @IBOutlet weak var table: UITableView!
    
    //associate this table with the data providing
    //we have to implement the data source protocall
    //set data source property to make a ui table
    var data:[String] = ["Item 1", "Item 2", "Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //safe to reference table view without nil
        //self for this instance of the class
        //we want to say this class supports this protocol
        table.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create UI cell, put correct info in it, return it
        let cell:UITableViewCell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    

}

