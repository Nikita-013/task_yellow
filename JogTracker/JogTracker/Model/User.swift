//
//  User.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import Foundation

class User {
	
	static var shared: User = { User() }()
	
	var token: String = ""
	var tokenType: String = ""
	var email: String = ""
	var firstName: String = ""
	var lastName: String = ""
	var id: String = ""
	var phone: String = ""
	var role: String = ""
	
	private init() {}
	
	func parseFrom(_ json: [String: AnyObject]) {
		guard
			let response = json["response"] as? [String: AnyObject],
			let email = response["email"] as? String,
			let firstName = response["first_name"] as? String,
			let id = response["id"] as? String,
			let lastName = response["last_name"] as? String,
			let phone = response["phone"] as? String,
			let role = response["role"] as? String
		else { return }
		
		self.email = email
		self.firstName = firstName
		self.id = id
		self.lastName = lastName
		self.phone = phone
		self.role = role
	}
}
