//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 10/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

}
