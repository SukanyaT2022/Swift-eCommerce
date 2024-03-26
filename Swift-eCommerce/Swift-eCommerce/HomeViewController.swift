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

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //numberOfItemsInSection how many box of cell in total-ex i want 10 cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    //cellForItemAt create each cell in each index path--then create 10 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell
                //ProductCollectionViewCell is class name
        else{
            return UICollectionViewCell()
        }
        cell.backgroundColor = .gray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 120, height: 140)
    }
    
}
