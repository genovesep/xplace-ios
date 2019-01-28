//
//  CarouselCell.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit

protocol MainCellDelegate {
    func reloadItemCollectionView(forIndex index: Int)
}

class MainCell: UITableViewCell {
    
    private enum CellIdentifier: String {
        case CarouselCell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedView: UIView!
    
    var delegate: MainCellDelegate?
    var selectedIndex = 0
    
    func customInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupSegmentedControl), name: NSNotification.Name(kNSNotificationName_productLoad), object: nil)
    }
    
    @objc func setupSegmentedControl() {
        let codeSegmented = CustomSegmentedControl(frame: segmentedView.bounds, buttonTitle: ["TODOS", "PROFISSIONAL", "CLIENTE"])
        codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self        
        segmentedView.addSubview(codeSegmented)
        segmentedView.isHidden = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(kNSNotificationName_productLoad), object: nil)
    }
}

extension MainCell: CustomSegmentedControlDelegate {
    func changeToIndex(index: Int) {
        self.delegate?.reloadItemCollectionView(forIndex: index)
    }
}

extension MainCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.CarouselCell.rawValue, for: indexPath) as! CarouselCell
        return cell
    }
}
