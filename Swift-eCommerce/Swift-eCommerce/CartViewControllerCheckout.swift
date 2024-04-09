//
//  CartViewControllerCheckout.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 4/9/24.

//ViewController is main screen hold all cell - it always need viewdidloag

import Foundation
import UIKit
class CartViewControllerCheckout:  UIViewController{
    @IBOutlet weak var cartTableView: UITableView!
    //line 14 below is coredata in entity and use to define how amny row and all detail
    var cartProduct : [ProductEntity]?
    
    
    override func viewDidLoad() {
     super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
}
extension CartViewControllerCheckout: UITableViewDelegate, UITableViewDataSource{
    //how many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cartProduct{
            return cartProduct.count + 1
        }else{
            return 0
            //else if no product return 0
        }
    }
    //how many cell we need if call 6 times it crate 5 row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < cartProduct?.count ?? 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        }else{
            //else for the total price and total qty cell
            
        }
    }
    
    
}
