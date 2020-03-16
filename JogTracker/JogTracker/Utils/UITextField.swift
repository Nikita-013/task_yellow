//
//  UITextField.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

extension UITextField {
	
	//MARK: - Internal Properties
	var isTimeValid: Bool {
    guard let text = text else { return false }
		let regex = RegexDefaults.time
		
		let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
		return predicate.evaluate(with: text)
  }
	
	var isDistanceValid: Bool {
    guard let text = text else { return false }
		let regex = RegexDefaults.distance
		
		let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
		return predicate.evaluate(with: text)
  }
	
	var isDateValid: Bool {
    guard let text = text else { return false }
		let regex = RegexDefaults.date
		
		let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
		return predicate.evaluate(with: text)
  }
 
  //MARK: - Internal Methods
  func makeEntranceField(withImage image: UIImage? = nil, sequre: Bool = false) {
    isSecureTextEntry = sequre
    
    setEntranceStyle()
    setPaddingPoints(10, for: .sides)
  }
  
  func setPaddingPoints(_ amount:CGFloat, for side: Side = .left) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    
    switch side {
      case .left:
        setLeftPaddingView(paddingView)
      case .right:
        setRightPaddingView(paddingView)
      case .sides:
        setLeftPaddingView(paddingView)
        setRightPaddingView(paddingView)
      default: return
    }
  }
  
  //MARK: - Private Methods
  private func setLeftPaddingView(_ view: UIView) {
    self.leftView     = view
    self.leftViewMode = .always
  }
  
  private func setRightPaddingView(_ view: UIView) {
    self.rightView     = view
    self.rightViewMode = .always
  }
	
	private func setEntranceStyle() {
    layer.borderWidth = 1
    layer.borderColor = Color.zebra.cgColor
    layer.cornerRadius = 13
    backgroundColor = Color.main
    tintColor = Color.zebra
  }
}
