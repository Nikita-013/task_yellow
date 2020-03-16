//
//  MenuTabBarController.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController {
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setViewControllers()
    configureController()
  }
  
  // MARK: - Configuration
  private func configureController() {
    selectedViewController = viewControllers?[1]
  }
  
  private func setViewControllers() {
    setTabBar()
  }
  
  private func setTabBar() {
    collectTabBarNavControllers()
    
    tabBar.tintColor = Color.selected
    tabBar.unselectedItemTintColor = Color.zebra
    tabBar.barTintColor = Color.bars
		tabBar.isTranslucent = false
  }
  
  private func setTabBarItemFor(_ controller: UIViewController,
                                title: String?,
                                image: UIImage?,
                                selectedImage: UIImage?,
                                tag: Int) {
    controller.tabBarItem = UITabBarItem(title: title,
                                         image: image,
                                         tag: tag)
    
    controller.tabBarItem.selectedImage = selectedImage
  }
  
  //MARK: - NavController
  private func setNavControllerWith(root: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: root)
		
		navigationController.navigationBar.isTranslucent = false
		navigationController.navigationBar.tintColor = Color.zebra
		navigationController.navigationBar.barTintColor = Color.bars
		
    return navigationController
  }
  
  // MARK: - Private Methods
	private func collectTabBarNavControllers() {
    let addJogNavController = setNavControllerWith(root: AddJogViewController())
    setTabBarItemFor(addJogNavController,
                     title: "Add Jog",
                     image: DefaultImages.addJog,
                     selectedImage: DefaultImages.addJogFill,
                     tag: 0)
		
		let jogsNavController = setNavControllerWith(root: JogsViewController())
    setTabBarItemFor(jogsNavController,
                     title: "Jogs",
                     image: DefaultImages.jogs,
                     selectedImage: DefaultImages.jogsFill,
                     tag: 1)
    
    viewControllers = [addJogNavController,
                       jogsNavController]
  }
}
