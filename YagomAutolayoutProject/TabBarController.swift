//
//  TabBarController.swift
//  YagomAutolayoutProject
//
//  Created by rbwo on 2024/01/06.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let floatVC = FloatingButtonViewController()
        let socialMediaTableVC = SocialMediaTableViewController()
        let messageVC = MessagingTableViewController()
        let barGraphVC = BarGraphViewController()
        let socialMediaProfileVC = SocialMediaProfileViewController()
        
        floatVC.tabBarItem.image = UIImage(systemName: "1.circle")
        socialMediaTableVC.tabBarItem.image = UIImage(systemName: "2.circle")
        messageVC.tabBarItem.image = UIImage(systemName: "3.circle")
        barGraphVC.tabBarItem.image = UIImage(systemName: "4.circle")
        socialMediaProfileVC.tabBarItem.image = UIImage(systemName: "5.circle")
        
        self.tabBar.backgroundColor = .lightGray
        self.view.backgroundColor = .white
        setViewControllers([floatVC, socialMediaTableVC, messageVC, barGraphVC, socialMediaProfileVC], animated: false)
    }

}
