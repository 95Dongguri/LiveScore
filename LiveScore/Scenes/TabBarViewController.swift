//
//  TabBarViewController.swift
//  LiveScore
//
//  Created by κΉλν on 2022/05/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarViewController: [UIViewController] = TabBarItem.allCases
            .map { tabCase in
                let vc = tabCase.viewController
                vc.tabBarItem = UITabBarItem(title: tabCase.title, image: tabCase.icon.default, selectedImage: tabCase.icon.selected)
                
                return vc
            }
        
        self.viewControllers = tabBarViewController
    }
}
