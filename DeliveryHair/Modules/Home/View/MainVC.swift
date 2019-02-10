//
//  ViewController.swift
//  DeliveryHair
//
//  Created by Guarneri Ferreira Genovese, Piero on 16/01/19.
//  Copyright © 2019 xSistemas. All rights reserved.
//

import UIKit
import SpriteKit

class MainVC: UIViewController {
    
    private enum CellIdentifier: String {
        case MainCell
        case ItemMainCell
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuContainerView: MenuView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var localProductArr: [Product] = []
    var filteredProductArr: [Product] = []
    var isShowingMenu = false
    var segmentedControlSelectedIndex = 0
    var itemIndexPath: IndexPath!
    var codeSegmented: CustomSegmentedControl?
    var selectedIndex = 0
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var carouselImgArr = [String]()
    var repeatTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        menuContainerView.delegate = self
        
        // REMOVER 
        let cart = try! UserDefaults.standard.get(objectType: Cart.self, forKey: DefaultsIDs.cartIdentifier)
        print("CART ITEMS: ", cart ?? 0)
    }
    
    func setupView() {
        navigationController?.navigationBar.backgroundColor = Colors.darkPink
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        pageControl.isUserInteractionEnabled = false
        scrollView.isUserInteractionEnabled = false
        
        repeatTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
        loadProducts()
    }
    
    func loadProducts() {
        LoadingVC.sharedInstance.show()
        ProductServices.shared.getAllProducts { (response) in
            LoadingVC.sharedInstance.hide()
            self.localProductArr = []
            if let productArr = response {
                DispatchQueue.main.async {                    
                    self.localProductArr = productArr                    
                    self.tableView.reloadData()
                    self.setCarousel()
                }
            } else {
                // TODO - ERROR
            }
        }
    }
    
    @objc func autoScroll() {
        let curPage = pageControl.currentPage
        if curPage == carouselImgArr.count - 1 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            pageControl.currentPage = 0
        } else {
            let x = CGFloat(curPage + 1) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            pageControl.currentPage = curPage + 1
        }
    }
    
    func setCarousel() {
        carouselImgArr = []
        localProductArr.forEach { (product) in
            guard let resp = product.productImages?.productImage else { return }
            carouselImgArr.append(resp)
        }
        pageControl.numberOfPages = carouselImgArr.count
        for index in 0..<carouselImgArr.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.contentMode = .scaleAspectFit
            imgView.downloadImage(fromStringUrl: carouselImgArr[index])
            scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(carouselImgArr.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    func toggleMenuShowHide() {
        menuLeadingConstraint.constant = isShowingMenu ? -250 : 0
        tableView.isScrollEnabled = isShowingMenu ? true : false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        isShowingMenu ? view.removeBlurView() : view.addBlurView()
        isShowingMenu = !isShowingMenu
    }
    
    func reloadData() {
        let rowToReload = NSIndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [rowToReload as IndexPath], with: .fade)
    }
    
    // MARK: delegate
    func goToDetail(forProduct product: Product) {
        DispatchQueue.main.async {
            let vc = UIStoryboard.ViewController.ProductDetailVC
            vc.product = product
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: actions
    @IBAction func didPressMenuButton(_ sender: Any) {
        toggleMenuShowHide()
    }
    
    @IBAction func cartButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            let vc = UIStoryboard.ViewController.cartVC
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func customSegmentValueChanged(_ sender: CustomSegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        filteredProductArr = []
        switch sender.selectedSegmentIndex {
        case 0:
            filteredProductArr = []
        case 1:
            localProductArr.forEach { (product) in
                let category = product.productCategorys
                if !category.isEmpty {
                    let slug = product.productCategorys[0].slug.lowercased()
                    if slug.contains("profissional") {
                        self.filteredProductArr.append(product)
                    }
                }
            }
        case 2: 
            localProductArr.forEach { (product) in
                let category = product.productCategorys
                if !category.isEmpty {
                    let slug = product.productCategorys[0].slug.lowercased()
                    if slug.contains("cliente") {
                        self.filteredProductArr.append(product)
                    }
                }
            }
        default:
            break
        }
        
        reloadData()
    }
}

// MARK: extensions
extension MainVC: MenuViewDelegate {
    func didPress(homeLoginButton button: Int) {
        if button == 0 {
            self.toggleMenuShowHide()
        } else {
            self.toggleMenuShowHide()
            DispatchQueue.main.async {
                let vc = UIStoryboard.ViewController.loginVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let device = GenericMethods.sharedInstance.getDevice()
        if !filteredProductArr.isEmpty {
            let cellHeight = GenericMethods.sharedInstance.getCellHeight(forDevice: device)
            let newCellHeight = CGFloat(cellHeight * filteredProductArr.count.toDouble())
            tableViewHeightConstraint.constant = newCellHeight - CGFloat(cellHeight)
            return newCellHeight
        } else {
            let cellHeight = GenericMethods.sharedInstance.getCellHeight(forDevice: device)
            let newCellHeight = CGFloat(cellHeight * localProductArr.count.toDouble())
            tableViewHeightConstraint.constant = newCellHeight - CGFloat(cellHeight)
            return newCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ItemMainCell.rawValue) as! ItemMainCell
        cell.delegate = self
        if !filteredProductArr.isEmpty {
            cell.localProductArr = self.filteredProductArr
        } else {
            cell.localProductArr = self.localProductArr
        }
        cell.customInit()
        return cell
    }
}

extension MainVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}

