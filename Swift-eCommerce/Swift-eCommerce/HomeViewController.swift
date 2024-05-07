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
    
    @IBOutlet var productSearchBar: UISearchBar!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    
    var productList : [Product]?
    var filterProductList : [Product]?
    var categoryList = ["All"]
    //: define type |  = assign
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    //search bar
        self.navigationItem.titleView = productSearchBar
        productSearchBar.delegate = self
        self.getProduct()
        getCategories()
    }
    //get all catergory on catergory cell on home page -- this function do is get data from api
    func getCategories(){
        //below for catergory section on homepage
        NetworkHelper().getCategories { result in
            switch result{
            case .success(let data):
                if let data{
                    self.categoryList.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self.categoryCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    get all product detail from api
    func getProduct(){
        NetworkHelper().getAllProducts { result in
            switch result{
            case .success(let data):
                self.productList = data
                self.filterProductList = data
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
        if collectionView == categoryCollectionView{
            return categoryList.count
        }else{
            return filterProductList?.count ?? 0
        }
      
    }
    //cellForItemAt create each cell in each index path--then create 10 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "catergoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else{
                return UICollectionViewCell()
            }
            let category = categoryList[indexPath.item]
            cell.catergoryLabel.text = category
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell
                    //ProductCollectionViewCell is class name
            else{
                return UICollectionViewCell()
            }
            
            //        array of productList
            
            let product = filterProductList?[indexPath.item]//indexpathline 46
            cell.productTitle.text = product?.title
            cell.productImageView.downloadImage(path: product?.image ?? "")
            cell.productData = product//product LINE 55
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        if collectionView == categoryCollectionView{
            let category = categoryList[indexPath.item]
            let size = (category as NSString).size()
            return CGSize(width: size.width + 40, height: 50)
        }else{
            return CGSize(width: 180, height: 160)
        }
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
//for search box and filter
extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      //do filter for search
        filterAndRefresh(text: searchText)//searchtext first from 103
    }
    func filterAndRefresh(text: String){
//        text isempyty mean not searching- when no text on search bar-show all product
        if text.isEmpty{
            filterProductList = productList
        }else{
            //if user type something show what search for
            filterProductList = productList?.filter({$0.title!.contains(text)})
        }
      
        ProductCollectionView.reloadData()
    }
}
