//
//  CartTableViewCell.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 4/4/24.
//

import Foundation
import UIKit
protocol CartTableViewCellDelegate:AnyObject{
    func deleteButtonClick(product:ProductEntity?)
}
class CartTableViewCell:UITableViewCell{
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var quantityStepper: UIStepper!
    weak var delegate:CartTableViewCellDelegate?
    
    var cartProduct : ProductEntity?
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        self.delegate?.deleteButtonClick(product: cartProduct)
    }
}
