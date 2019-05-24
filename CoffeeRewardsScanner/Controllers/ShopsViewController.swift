//
//  ShopsViewController.swift
//  CoffeeRewardsScanner
//
//  Created by Wilson Desimini on 5/23/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit


protocol ShopsViewControllerDelegate: class {
    func didSelectShop(_ shop: Shop)
}

class ShopsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ShopsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}
