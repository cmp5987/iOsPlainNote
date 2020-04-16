//
//  DetailViewController.swift
//  Plain Notes
//
//  Created by catie on 4/16/20.
//  Copyright © 2020 cmp5987. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var text:String = ""
    var masterView:ViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textView.text = text
        
        self.navigationItem.largeTitleDisplayMode = .never
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //first responder is the object recieving events currently
        textView.becomeFirstResponder()
    }
    
    func setText(t:String){
        //modify text property and update the text view
        text = t
        
        //only modify text view after text is loaded because textView is implicity unwrapped
        if isViewLoaded{
            
        
            textView.text = t
        }
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
        textView.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
