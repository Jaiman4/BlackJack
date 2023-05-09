//
//  manageAccountViewController.swift
//  BlackJack
//
//  Created by Jaiman Gupta on 18/2/2023.
//

import UIKit

class manageAccountViewController: UIViewController {
    
    @IBOutlet weak var addFeild: UITextField!
    
    @IBOutlet weak var AccountBalance: UILabel!
    
    
    
    @IBAction func addButton(_ sender: Any) {
        
        money += Int(addFeild.text!)!
        AccountBalance.text = String(money)
        addFeild.text = nil

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountBalance.text = String(money)


        
        // Do any additional setup after loading the view.
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
