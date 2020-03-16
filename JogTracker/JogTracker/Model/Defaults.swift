//
//  Defaults.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/15/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

//MARK: - LoginDefaults
struct LoginDefaults {
	static var buttonPadding:			 CGFloat { 20 }
	static var buttonHeight: 			 CGFloat { 60 }
	static var buttonCornerRadius: CGFloat { 13 }
	static var uuid:							 String { "hello" }
}

//MARK: - DefaultImages
struct DefaultImages {
  static var jogs:       UIImage? { UIImage(named: "Jogs") }
  static var jogsFill:   UIImage? { UIImage(named: "Jogs.fill") }
	static var addJog:     UIImage? { UIImage(named: "Add") }
  static var addJogFill: UIImage? { UIImage(named: "Add.fill") }
}

//MARK: - JogsDefaults
struct JogsDefaults {
	static var rowHeight:    CGFloat { 80 }
	static var rowTopHeight: CGFloat { 40 }
	static var cellID:       String { "JogCellID" }
}

//MARK: - AddJogDefaults
struct AddJogDefaults {
	static var textFieldHeight:  CGFloat { 50 }
	static var labelHeight: 		 CGFloat { 40 }
	static var spaceAfterLabel:  CGFloat { 35 }
	static var spaceAfterFields: CGFloat { 55 }
	static var space: 					 CGFloat { 20 }
	static var buttonViewHeight: CGFloat { 70 }
	static var buttonPaddingV:   CGFloat { 5 }
	static var buttonPaddingH:   CGFloat { 60 }
}

//MARK: - RegexDefaults
struct RegexDefaults {
	static var time:     String { "^[1-9]+[0-9]*$" }
	static var date:     String { #"^([0-2][0-9]|(3)[0-1])(\.)(((0)[0-9])|((1)[0-2]))(\.)\d{4}$"# }
	static var distance: String { #"^[+]?([0-9]+(?:[\.][0-9]*)?|\.[0-9]+)$"# }
}
