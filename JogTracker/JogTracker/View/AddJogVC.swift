//
//  AddJogViewController.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

class AddJogViewController: BaseViewController {
	
	//MARK: - Internal Properties
	var stackView = UIStackView()
	var label = UILabel()
	var distanceTextField = UITextField()
	var timeTextField = UITextField()
	var dateTextField = UITextField()
	var buttonView = UIView()
	var addButton = UIButton()
	
	var jog: Jog?
	var isEdit: Bool = false
	
	//MARK: - Lifecycle
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		distanceTextField.layer.borderColor = Color.zebra.cgColor
		timeTextField.layer.borderColor = Color.zebra.cgColor
		dateTextField.layer.borderColor = Color.zebra.cgColor
	}
	
  override func addViewParametres() {
		view.backgroundColor = Color.main
		navigationItem.title = "Jog Tracker"
	}
	
  override func addSubviews() {
		view.addSubview(stackView)
	}
	
  override func configureProperties() {
		configureStackView()
		configureTextFields()
		configureLabel()
		configureButton()
	}
	
	//MARK: - TextFields
	private func configureTextFields() {
		distanceTextField.makeEntranceField()
		distanceTextField.placeholder = "Distance in km"
		distanceTextField.delegate = self
		distanceTextField.returnKeyType = .next
		distanceTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		
		timeTextField.makeEntranceField()
		timeTextField.placeholder = "Time"
		timeTextField.delegate = self
		timeTextField.returnKeyType = .next
		timeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		
		dateTextField.makeEntranceField()
		dateTextField.placeholder = "Date dd.mm.yyyy (Not obligitary)"
		dateTextField.delegate = self
		dateTextField.returnKeyType = .done
		dateTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
	}
	
	//MARK: - Label
	private func configureLabel() {
		label.text = isEdit ? "Jog Edition" : "Add new Jog"
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textColor = Color.zebra
	}
	
	//MARK: - Button
	private func configureButton() {
		buttonView.addSubview(addButton)
		buttonView.isUserInteractionEnabled = true
		
		addButton.backgroundColor = isEdit ? Color.entranceButton : Color.gray
		addButton.setTitle("Save", for: .normal)
		addButton.setTitleColor(Color.zebra, for: .normal)
		addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
		addButton.layer.cornerRadius = LoginDefaults.buttonCornerRadius
		addButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
	}
	
	@objc
	private func buttonDidTap() {
		if addButton.backgroundColor == Color.entranceButton {
			isEdit ? editJog() : saveJog()
		}
	}
	
	//MARK: - StackView
	private func configureStackView() {
		stackView.axis = .vertical
		
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(distanceTextField)
		stackView.addArrangedSubview(timeTextField)
		stackView.addArrangedSubview(dateTextField)
		stackView.addArrangedSubview(buttonView)
		stackView.addArrangedSubview(UIView())
		
		stackView.setCustomSpacing(AddJogDefaults.spaceAfterLabel, after: label)
		stackView.setCustomSpacing(AddJogDefaults.space, after: distanceTextField)
		stackView.setCustomSpacing(AddJogDefaults.space, after: timeTextField)
		stackView.setCustomSpacing(AddJogDefaults.spaceAfterFields, after: dateTextField)
	}
	
	//MARK: - Actions
	@objc
	private func textFieldDidChange() {
		if timeTextField.isTimeValid, distanceTextField.isDistanceValid,
			(dateTextField.isDateValid || (dateTextField.text?.isEmpty ?? false)) {
			addButton.backgroundColor = Color.entranceButton
		} else {
			addButton.backgroundColor = Color.gray
		}
	}
	
	//MARK: - Internal Methods
	func setJog(_ jog: Jog) {
		self.jog = jog
		
		let date = NSDate(timeIntervalSince1970: TimeInterval(jog.date))
		
		distanceTextField.text = "\(jog.distance)"
		timeTextField.text = "\(jog.time)"
		dateTextField.text = stringFromDate(date, time: false)
	}
	
	//MARK: - Private Methods
	private func getDataFromTextFields() -> (date: String, distance: String, time: String)? {
		guard
			let time = timeTextField.text,
			let distance = distanceTextField.text
		else { return nil }
		
		var date = ""
		
		if let dateText = dateTextField.text, !dateText.isEmpty {
			date = dateText
		} else {
			date = stringFromDate(NSDate(timeIntervalSince1970: Double(NSDate().timeIntervalSince1970)), time: true)
		}
		
		return (date, distance, time)
	}
	
	private func saveJog() {
		guard let data = getDataFromTextFields() else { return }
		
		createDataTask(
			urlString: "https://jogtracker.herokuapp.com/api/v1/data/jog",
			param: ["time": data.time, "date": data.date, "distance": data.distance],
			httpMethod: "POST",
			headerValues: ["Authorization": "\(User.shared.tokenType.capitalized) \(User.shared.token)",
										 "Accept": "application/json",
										 "Content-Type": "application/x-www-form-urlencoded"]) { _ in
			
		}
		
		distanceTextField.text = nil
		timeTextField.text = nil
		dateTextField.text = nil
		view.endEditing(true)
		addButton.backgroundColor = Color.gray
	}
	
	private func editJog() {
		guard
			let data = getDataFromTextFields(),
			let id = jog?.id,
			let userID = jog?.userId
		else { return }
		
		createDataTask(
			urlString: "https://jogtracker.herokuapp.com/api/v1/data/jog",
			param: ["time": data.time, "date": data.date, "distance": data.distance, "jog_id": "\(id)", "user_id": userID],
			httpMethod: "PUT",
			headerValues: ["Authorization": "\(User.shared.tokenType.capitalized) \(User.shared.token)",
										 "Accept": "application/json",
										 "Content-Type": "application/x-www-form-urlencoded"]) { _ in
				
		}
		navigationController?.popViewController(animated: true)
	}
	
	//MARK: - Constraints
  override func setConstraints() {
		setStackViewConstraints()
		setStackViewSubviewsConstraints()
		setAddButtonConstraints()
	}
	
	private func setStackViewConstraints() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	private func setStackViewSubviewsConstraints() {
		label.translatesAutoresizingMaskIntoConstraints = false
		label.heightAnchor.constraint(equalToConstant: AddJogDefaults.labelHeight).isActive = true
		
		distanceTextField.translatesAutoresizingMaskIntoConstraints = false
		distanceTextField.heightAnchor.constraint(equalToConstant: AddJogDefaults.textFieldHeight).isActive = true
		
		timeTextField.translatesAutoresizingMaskIntoConstraints = false
		timeTextField.heightAnchor.constraint(equalToConstant: AddJogDefaults.textFieldHeight).isActive = true
		
		dateTextField.translatesAutoresizingMaskIntoConstraints = false
		dateTextField.heightAnchor.constraint(equalToConstant: AddJogDefaults.textFieldHeight).isActive = true
		
		buttonView.translatesAutoresizingMaskIntoConstraints = false
		buttonView.heightAnchor.constraint(equalToConstant: AddJogDefaults.buttonViewHeight).isActive = true
	}
	
	private func setAddButtonConstraints() {
		let horizontalPadding = AddJogDefaults.buttonPaddingH
		let verticalPadding = AddJogDefaults.buttonPaddingV
		
		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
		addButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
		addButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: verticalPadding).isActive = true
		addButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: horizontalPadding).isActive = true
	}
}

//MARK: - UITextFieldDelegate
extension AddJogViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == distanceTextField {
			timeTextField.becomeFirstResponder()
		} else if textField == timeTextField {
			dateTextField.becomeFirstResponder()
		} else if textField == dateTextField {
			view.endEditing(true)
		}
    return false
  }
  
}
