//
//  ProductDetailViewController.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 3/28/24.
//create screen parent/ somthing elase image cell is outlet on the screen -> UIViewController create screen /if  uitableviewcell make table

import Foundation
import UIKit
class ProductDetailViewController: UIViewController{
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var product : Product?//Product from model
    
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
        descriptionLabel.text = product?.description
        
        categoryLabel.text = product?.category
        if let imagePath = product?.image{
            productImageView.downloadImage(path: imagePath)
            //downloadImage  is function in HomeViewController file
        }
        
        
    }
    @IBAction func addtoCartButtonAction(_ sender: Any) {
    }
    
}
