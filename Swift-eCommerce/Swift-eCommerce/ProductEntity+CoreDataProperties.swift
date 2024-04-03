//
//  ProductEntity+CoreDataProperties.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 4/3/24.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var productID: Int16
    @NSManaged public var productTitle: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var productCategory: String?
    @NSManaged public var productImage: String?
    @NSManaged public var productRating: Double
    @NSManaged public var productQuantity: Int16

}

extension ProductEntity : Identifiable {

}
