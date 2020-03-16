//
//  JogsViewController.swift
//  JogTracker
//
//  Created by Nikita Grishin on 3/16/20.
//  Copyright © 2020 Nikita Grishin. All rights reserved.
//

import UIKit

class JogsViewController: BaseViewController {
	
	//MARK: - Internal Properties
	var tableView = UITableView()
	var jogs: [Jog] = []
	
	//MARK: - Lifecycle
	override func loadView() {
		super.loadView()
		createDataTask(
			urlString: "https://jogtracker.herokuapp.com/api/v1/data/sync",
			param: nil,
			httpMethod: "GET",
			headerValues: ["Authorization": "\(User.shared.tokenType.capitalized) \(User.shared.token)"]) { json in
				guard
					let response = json["response"] as? [String: AnyObject],
					let jogsJSONs = response["jogs"] as? [[String: AnyObject]]
				else { return }
				
				var jogs: [Jog] = []
				
				jogsJSONs.forEach {
					guard
						let date = $0["date"] as? Int,
						let distance = $0["distance"] as? Double,
						let id = $0["id"] as? Int,
						let time = $0["time"] as? Int,
						let userID = $0["user_id"] as? String
					else { return }
					
					let jog = Jog(id: id, userId: userID, distance: distance, time: time, date: date)
					
					if jog.userId == User.shared.id {
						jogs.append(jog)
					}
				}
				
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					
					self.jogs = jogs
					self.tableView.reloadData()
				}
		}
	}
	
  override func addViewParametres() {
		view.backgroundColor = Color.main
		navigationItem.title = "Jog Tracker"
	}
	
  override func addSubviews() {
		view.addSubview(tableView)
	}
	
  override func configureProperties() {
		tableView.tableFooterView = UIView()
		tableView.register(JogCell.self, forCellReuseIdentifier: JogsDefaults.cellID)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.refreshControl = UIRefreshControl()
		configureRefresher()
	}
	
	private func configureRefresher() {
		guard let refresher = tableView.refreshControl else { return }
		
		refresher.addTarget(self, action: #selector(populate), for: UIControl.Event.valueChanged)
	}
	
	@objc
	private func populate() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
		tableView.refreshControl?.endRefreshing()
	}
	
	//MARK: - Constraints
  override func setConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}

//MARK: - UITableViewDelegate
extension JogsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    JogsDefaults.rowHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

//MARK: - UITableViewDataSource
extension JogsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		jogs.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: JogsDefaults.cellID) as? JogCell else {
			return UITableViewCell()
		}
		
		cell.setJog(jogs[indexPath.row])
		cell.selector = { [weak self] in
			guard let self = self else { return }
			
			let jogVC = AddJogViewController()
			
			jogVC.isEdit = true
			jogVC.setJog(self.jogs[indexPath.row])
			
			self.navigationController?.pushViewController(jogVC, animated: true)
		}
		
		return cell
	}
	
	
}
