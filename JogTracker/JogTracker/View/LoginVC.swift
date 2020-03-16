//
//  ViewController.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/12/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
	
	//MARK: - Internal Properties
	var button = UIButton(type: .roundedRect)
	
	//MARK: - Lifecycle
	override func addViewParametres() {
		view.backgroundColor = Color.main
	}
	
	override func addSubviews() {
		view.addSubview(button)
	}
	
	override func configureProperties() {
		configureButton()
	}
	
	//MARK: - Button
	private func configureButton() {
		button.backgroundColor = Color.entranceButton
		button.setTitle("Log In", for: .normal)
		button.setTitleColor(Color.zebra, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
		button.layer.cornerRadius = LoginDefaults.buttonCornerRadius
		button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
	}
	
	//MARK: - Actions
	@objc
	private func buttonDidTap() {
		createDataTask(
			urlString: "https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin",
			param: ["uuid": LoginDefaults.uuid],
			httpMethod: "POST",
			headerValues: ["Content-Type": "application/x-www-form-urlencoded"]) { [weak self] json in
				guard
					let response = json["response"] as? [String: AnyObject],
					let token = response["access_token"] as? String,
					let tokenType = response["token_type"] as? String,
					let self = self
				else { return }
				
				User.shared.token = token
				User.shared.tokenType = tokenType
				
				self.createDataTask(
					urlString: "https://jogtracker.herokuapp.com/api/v1/auth/user",
					param: nil,
					httpMethod: "GET",
					headerValues: ["Authorization": "\(tokenType.capitalized) \(token)"]) { [weak self] json in
						guard let self = self else { return }
						
						User.shared.parseFrom(json)
						self.switchViewController(MenuTabBarController())
				}
		}
	}
	
	//MARK: - Constraints
	override func setConstraints() {
		button.translatesAutoresizingMaskIntoConstraints = false
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		button.heightAnchor.constraint(equalToConstant: LoginDefaults.buttonHeight).isActive = true
		button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LoginDefaults.buttonPadding).isActive = true
	}

}

