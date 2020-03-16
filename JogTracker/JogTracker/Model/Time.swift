//
//  Time.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import Foundation

typealias Time = (hours: Int, minutes: Int, seconds: Int)

func secondsToHoursMinutesSeconds(_ seconds : Int) -> Time {
	return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func stringFromDate(_ date: NSDate, time: Bool) -> String {
  let formatter = DateFormatter()
	formatter.dateFormat = time ?  "dd.MM.yyyy    HH:mm:ss" : "dd.MM.yyyy"
  return formatter.string(from: date as Date)
}
