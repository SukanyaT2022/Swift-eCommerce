//
//  HomeViewController.swift
//  Swift-eCommerce
//
//  Created by Tiparpron Sukanya on 3/21/24.
//

import Foundation
import UIKit
class HomeViewController:
    UIViewController{
    //after connect 4 tab of cell show below line
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    var productList : [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        self.getProduct()
    }
//    get all product detail from api
    func getProduct(){
        NetworkHelper().getAllProducts { result in
            switch result{
            case .success(let data):
                self.productList = data
                self.refreshView()
            case .failure(let error):
                print(error)
            }
        }
    }
    func refreshView(){
        DispatchQueue.main.async {
            self.ProductCollectionView.reloadData()
        }
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //numberOfItemsInSection how many box of cell in total-ex i want 10 cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList?.count ?? 0
    }
    //cellForItemAt create each cell in each index path--then create 10 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell
                //ProductCollectionViewCell is class name
        else{
            return UICollectionViewCell()
        }

//        array of productList
        
        let product = productList?[indexPath.item]//indexpathline 46
        cell.productTitle.text = product?.title
        cell.productImageView.downloadImage(path: product?.image ?? "")
        cell.productData = product//product LINE 55
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 180, height: 160)
    }
    //identify which item is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell
        //for navigation perform seque
        performSegue(withIdentifier:"connectDetailProduct" , sender: cell?.productData)
        //productData from variable productCollectionViewcell file
    }
   //below for pass the data to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailVC = segue.destination as? ProductDetailViewController
        productDetailVC?.product = sender as? Product
    }
}
extension UIImageView{
    func downloadImage(path: String){
        URLSession.shared.dataTask(with: URL(string: path)!) { data, response, error in
            if let data{
                let image = UIImage(data: data)
                DispatchQueue.main.async{
                    self.image = image
                }
            
            }
        }.resume()
        
        
    }
}
