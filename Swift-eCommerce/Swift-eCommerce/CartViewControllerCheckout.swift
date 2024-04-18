//
//  CartViewControllerCheckout.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 4/9/24.

//ViewController is main screen hold all cell - it always need viewdidloag

import Foundation
import UIKit
import CoreData
class CartViewControllerCheckout:  UIViewController{
    @IBOutlet weak var cartTableView: UITableView!
    //line 14 below is coredata in entity and use to define how amny row and all detail
    var cartProduct : [ProductEntity]? = nil
    var totalPrice : Double = 0
    var totalQty = 0
    
    override func viewDidLoad() {
     super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartProduct()
    }
    //below get product list from core data
    func getCartProduct(){
        let fetchRequest = ProductEntity.fetchRequest()
        cartProduct = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(fetchRequest)
        updateQtyandPrice()
        cartTableView.reloadData()
        
    }
    func updateQtyandPrice(){
        if let cartProduct{
            totalQty = 0
            totalPrice = 0
            for product in cartProduct{
                let qty = product.productQuantity
                totalQty += Int(qty) //add qty to totalQty
                totalPrice += product.productPrice
                
            }
        }
    }
}
extension CartViewControllerCheckout: UITableViewDelegate, UITableViewDataSource{
    //how many rows--for products
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cartProduct, cartProduct.count > 0{
            return cartProduct.count + 1
            //cartProduct.count--depense on how many products user add + 1 is final total section
        }else{
            return 0
            //else if no product return 0
        }
    }
    //how many cell crate 5 row plus row for final total-- so we have 6 row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //line below for crate product cell only
        if indexPath.row < cartProduct?.count ?? 0{
            //crate product
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartProductCell", for: indexPath) as? CartTableViewCell else{
                return UITableViewCell()
            }
            
            //below get product from ech row
            let product = cartProduct?[indexPath.row]
            cell.productTitleLabel.text = product?.productTitle//product tile and after = come form coredata
            cell.productQuantityLabel.text = "\(product?.productQuantity ?? 0)"
            cell.priceLabel.text = "$ \(product?.productPrice ?? 0)"
            cell.quantityStepper.value = Double(product?.productQuantity ?? 1)
            cell.quantityStepper.addAction(UIAction(title: "", handler: { action in
                self.updateQuantity(product: product,value: Int(cell.quantityStepper.value))
                cell.productQuantityLabel.text = "\(Int(cell.quantityStepper.value))"
            }), for: .valueChanged)
            cell.cartProduct = product
            cell.delegate = self
            //delete button
//            cell.deleteButton.addAction(UIAction(title:"", handler: { action in
//                self.deleteProduct(product: product)//left name od parameter / right is value var
//            }), for:.touchUpInside )
            if let imagePath = product?.productImage{
                cell.productImageView.downloadImage(path: imagePath)
            }
                
            return cell
        }else{
            //else is for the total price and total qty cell
            //crate price final total sale
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartPriceCell", for: indexPath) as? CartPriceTableViewCell else{
                return UITableViewCell()
            }
            //guard let always come with else
            //if cell create go line 53 -- if not crate go to line 48 crate defaut cell/blank cell
            cell.qtyLabel.text = "\(totalQty)"
            cell.totalPriceLabel.text = "$ \(totalPrice)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
    }
    func updateQuantity(product : ProductEntity?, value : Int){
        totalQty -= Int(product?.productQuantity ?? 1)
        totalQty += value
        //below is refresh or reload of the last row
        cartTableView.reloadRows(at: [IndexPath(row: cartProduct?.count ?? 0, section: 0)], with: .automatic)
        product?.productQuantity = Int16(value)
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    func deleteProduct(product: ProductEntity?){
        let alertController = UIAlertController(title: "Alert", message: "Do you want to delete?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { action in
         
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,let product = product{
                appDelegate.persistentContainer.viewContext.delete(product)
                appDelegate.saveContext()
                self.getCartProduct()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
        
    }
}
extension CartViewControllerCheckout: CartTableViewCellDelegate{
    func deleteButtonClick(product: ProductEntity?) {
   deleteProduct(product: product)
    }
    
    
}
