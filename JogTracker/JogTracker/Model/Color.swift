//
//  Color.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/15/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

struct Color {
	static var main: 				   UIColor { return UIColor(named: "Main") ?? .lightGray }
	static var entranceButton: UIColor { return UIColor(named: "EntranceButton") ?? .green }
	static var zebra: 				 UIColor { return UIColor(named: "Zebra") ?? .gray }
	static var selected: 			 UIColor { return UIColor(named: "Selected") ?? .purple }
	static var bars: 			 		 UIColor { return UIColor(named: "Bars") ?? .darkGray }
	static var gray: 			 		 UIColor { return UIColor(named: "Gray") ?? .gray }
}
