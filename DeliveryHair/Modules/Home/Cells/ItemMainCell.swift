//
//  ItemMainCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

class ItemMainCell: UITableViewCell {
    
    private enum CellIdentifier: String {
        case ItemCell
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    var localProductArr: [Product] = []
    
    func customInit() {
        setupView()
    }
    
    func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension ItemMainCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localProductArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.ItemCell.rawValue, for: indexPath) as! ItemCell        
        cell.customInit(withProduct: localProductArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIScreen.main.bounds.height {
        case 568:
            return CGSize(width: 130, height: 230)
        case 736:
            return CGSize(width: 178, height: 278)
        case 896:
            return CGSize(width: 180, height: 286)
        default:
            return CGSize(width: 168, height: 268)
        }
    }
}
