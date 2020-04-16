//
//  ViewController.swift
//  Plain Notes
//
//  Created by catie on 4/15/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{


    @IBOutlet weak var table: UITableView!
    
    //associate this table with the data providing
    //we have to implement the data source protocall
    //set data source property to make a ui table
    var data:[String] = []
    //no row has been selected if -1
    var selectedRow:Int = -1
    
    var newRowText:String = ""
    
    //implicty unwrapped optional
    var fileUrl:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //safe to reference table view without nil
        //self for this instance of the class
        //we want to say this class supports this protocol
        table.dataSource = self
        
        //adding delegate for table view
        table.delegate = self
        
        
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        
        //built into super class
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        //need file url before we load
        //must be marked with try statement even though it is not going to fail
        //!try is forced but it will not handle the error because we know we won't get an exception
        //file url for document directory
        let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        //load notes
        
        fileUrl = baseURL.appendingPathComponent("notes.txt")
        
        load()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1{
            return
        }
        data[selectedRow] = newRowText
        if newRowText == ""{
            data.remove(at: selectedRow)
        }
        table.reloadData()
        save()
    }
    
    @objc func addNote(){
        
        //check if table is in editing mode
        if table.isEditing{
            return
        }
        //add row to table view
        let name:String = ""
        data.insert(name, at: 0)
        
        //create index path
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        
        //when a row is added, it is selected so this can be passed to the segue
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        //save notes
        //save()
        self.performSegue(withIdentifier: "detail", sender: nil)
        
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
    
    //This is used for selection of a row in a table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(data[indexPath.row])")
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //force the type cast
        let detailView:DetailViewController = segue.destination as! DetailViewController
        
        selectedRow = table.indexPathForSelectedRow!.row
        
        //setting master view property
        detailView.masterView = self
        
        detailView.setText(t: data[selectedRow])
    }
    
    func save(){
        //save whenever we change data so add a call whenever this happens
        //UserDefaults.standard.set(data, forKey: "notes")
        
        let a = NSArray(array: data)
        do {
            try a.write(to: fileUrl)
        } catch  {
            print("error writing to file")
        }
        
    }
    func load(){
        //if let loadedData:[String] = UserDefaults.standard.value(forKey: "notes") as? [String] {
        //    data = loadedData
        //    table.reloadData()
        //}
        if let loadedData:[String] = NSArray(contentsOf: fileUrl) as? [String]{
            data = loadedData
            table.reloadData()
        }
    }
    

}

