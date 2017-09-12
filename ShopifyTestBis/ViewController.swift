//
//  ViewController.swift
//  ShopifyTestBis
//
//  Created by Alexandre Impinna on 11/09/2017.
//  Copyright © 2017 Alexandre Impinna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var email : [String] = []
    
    var firstName : [String] = []
    var lastName : [String] = []
    

    
    var amountSpent : String = "Not a single dollar spent! ☹️"
    
    @IBOutlet weak var amountSpentLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var awesomeBronzeBagLabel: UILabel!
    
    var names : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        customerLabel.text = "No customer found ☹️"
        
        let url = URL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
        do {
            
            let data = try Data(contentsOf: url!)
            
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject]
            
            var totaly : Float = 0.0
            
            var awesomeBronzeBags = 0
            
            let firstNameSearched = firstNameTextField.text?.capitalized
            let lastNameSearched = lastNameTextField.text?.capitalized
            
            if let orders = json?["orders"] {

                for index in 0...orders.count-1 {
                    
                // Je charge l'object JSON
                let object = orders[index] as! [String : AnyObject]
                    
                    let line_items = object["line_items"] as? [AnyObject]
                    
                    for i in 0...(line_items?.count)!-1 {
                        
                        
                        
                        let item = line_items?[i]["title"] as! String
                        
                        if item == "Awesome Bronze Bag" {
                            
                            awesomeBronzeBags += 1
                        }   
                        
                        if awesomeBronzeBags == 0 {
                            
                            awesomeBronzeBagLabel.text = "and we didn't sold a single Awesome Bronze Bags! ☹️"
                            
                        } else {
                            
                            awesomeBronzeBagLabel.text = "and we sold \(awesomeBronzeBags) Awesome Bronze Bags! 👜"
                            
                        }

                        
                    }
                    
                    // Je cherche la key "customer"
                    if let customer = object["customer"] as? [String : Any] {
                        

                        // Je cherche les keys d'identifications
                        let first_name = customer["first_name"] as? String
                        let last_name = customer["last_name"] as? String
                        
                        
                    
                        
                        // Si la key "first_name" et "last_name" correspondent
                        if first_name == firstNameSearched && last_name == lastNameSearched {
                            
                            customerLabel.text = "Our favorite customer, \(firstNameSearched!) \(lastNameSearched!) spent... 🥁"
                            
                            let total_price = object["total_price"] as? String
                            
                            totaly = totaly + Float(total_price!)!
                            
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            
            if totaly > 0 {
                
                amountSpentLabel.text = "\(totaly)$! 💸"
                
            } else {
                
                amountSpentLabel.text = "Not a single dollar! ☹️"
                
            }
            
            
        } catch {
            
            print(error)
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

