//
//  BaseViewController.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/15/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  //MARK: - Lifecycle
  override func loadView() {
    super.loadView()
    initProperties()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  final func configureView() {
    addViewParametres()
    addSubviews()
    configureProperties()
    setConstraints()
  }
  
  ///Override to use
  func initProperties() {}
  func addViewParametres() {}
  func addSubviews() {}
  func configureProperties() {}
  func setConstraints() {}
  
  func switchViewController(_ controller: BaseViewController) {
    let nextViewController = controller
    let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    keyWindow?.rootViewController = nextViewController
  }
  
}
