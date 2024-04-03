//
//  ProductCollectionViewCell.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 3/26/24.
//

import Foundation
import UIKit
class ProductCollectionViewCell:UICollectionViewCell{
    var productData: Product?// Product from Modal
    
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
}
