//
//  ProductDetailViewController.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 3/28/24.
//create screen parent/ somthing elase image cell is outlet on the screen -> UIViewController create screen /if  uitableviewcell make table

import Foundation
import UIKit
import CoreData
class ProductDetailViewController: UIViewController{
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    @IBOutlet weak var QuantityLabel: UILabel!
    
    
    var product : Product?//Product from model
    var quantity = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData() //line 31
    }
    //text = string , 2.3 double , 2 is int
    func displayData(){
        productTitleLabel.text = product?.title
        ratingLabel.text = "\(product?.rating?.rate ?? 0)" //rating?.rate from model
        //"/()" above convert to string format
        priceLabel.text = "$\(product?.price ?? 0)"
       descriptionTextView.text = product?.description
        
        categoryLabel.text = product?.category
        if let imagePath = product?.image{
            productImageView.downloadImage(path: imagePath)
            //downloadImage  is function in HomeViewController file
        }
        QuantityLabel.text = "\(quantity)"
        
    }
    @IBAction func addtoCartButtonAction(_ sender: Any) {
       saveProduct()
    }
    
    @IBAction func QuantityStepperAction(_ sender: UIStepper) {
        let stepperValue = sender.value
        quantity = Int(stepperValue)
        QuantityLabel.text = "\(quantity)"
    }
    func saveProduct(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            //update product quantity
            let fetchRequest = ProductEntity.fetchRequest()
            if  let existingProducts = (try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest) as? [ProductEntity]),
                let productToUpdate = existingProducts.filter({$0.productID == Int16(product?.id ?? 0)}).first{
                productToUpdate.productQuantity = Int16(quantity)
                appDelegate.saveContext()
//                this line make the the cart go back to the first screen
                self.navigationController?.popViewController(animated: true)
                return
            }
            let description = NSEntityDescription.entity(forEntityName: "ProductEntity", in:appDelegate.persistentContainer.viewContext)
            //entity name in coredata ProductEntity
            //below we crate entity
            let entity = NSManagedObject(entity: description!, insertInto: appDelegate.persistentContainer.viewContext) as? ProductEntity
//            entity?.coredata page
            //product?.title - from model
            //below loading data in entity
            entity?.productID = Int16(product?.id ?? 0)
            entity?.productTitle = product?.title
            entity?.productPrice = product?.price ?? 0
            entity?.productDescription = product?.description
            entity?.productCategory = product?.category
            entity?.productImage = product?.image
            entity?.productRating = product?.rating?.rate ?? 0
            entity?.productQuantity = Int16(quantity)
            //quantity is var ehen user add
            //sae change
            appDelegate.saveContext()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
