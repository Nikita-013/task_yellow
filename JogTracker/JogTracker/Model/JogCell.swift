//
//  JogCell.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

class JogCell: UITableViewCell {
	
	//MARK: - Internal Properties
	var stackView = UIStackView()
	var distanceLabel = UILabel()
	var timeLabel = UILabel()
	var dateLabel = UILabel()
	
	var jog: Jog?
	var selector: (() -> Void)?
	
	//MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = Color.main
    configureProperties()
    addSubviews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
	
	//MARK: - Lifecycle
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		if selected { selector?() }
	}
	
	private func configureProperties() {
		configureStackView()
		configureLabels()
	}
	
	//MARK: - StackView
	private func configureStackView() {
		stackView.addArrangedSubview(distanceLabel)
		stackView.addArrangedSubview(timeLabel)
		stackView.addArrangedSubview(dateLabel)
		stackView.axis = .vertical
	}
	
	//MARK: - Labels
	private func configureLabels() {
		distanceLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
		dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
	}
	
	private func addSubviews() {
		addSubview(stackView)
	}
	
	//MARK: - Internal Methods
	func setJog(_ jog: Jog) {
		self.jog = jog
		
		let time: Time = secondsToHoursMinutesSeconds(jog.time)
		let date = NSDate(timeIntervalSince1970: TimeInterval(jog.date))
		
		distanceLabel.text = "\(jog.distance) km"
		timeLabel.text = "\(time.hours) h  \(time.minutes) m  \(time.seconds) s"
		dateLabel.text = stringFromDate(date, time: true)
	}
	
	//MARK: - Constraints
	private func setConstraints() {
		setStackViewConstraints()
	}
	
	private func setStackViewConstraints() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
}
