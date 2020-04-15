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
    var data:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //safe to reference table view without nil
        //self for this instance of the class
        //we want to say this class supports this protocol
        table.dataSource = self
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        
        //built into super class
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        //load notes
        load()
    }
    
    @objc func addNote(){
        
        //check if table is in editing mode
        if table.isEditing{
            return
        }
        //add row to table view
        let name:String = "Item \(data.count + 1)"
        data.insert(name, at: 0)
        
        //create index path
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        
        //save notes
        save()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create UI cell, put correct info in it, return it
        let cell:UITableViewCell = table.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        
        //save deletes
        save()
    }
    
    func save(){
        //save whenever we change data so add a call whenever this happens
        UserDefaults.standard.set(data, forKey: "notes")
    }
    func load(){
        if let loadedData:[String] = UserDefaults.standard.value(forKey: "notes") as? [String] {
            data = loadedData
            table.reloadData()
        }
    }
    

}

