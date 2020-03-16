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
  
  func switchViewController(_ controller: UIViewController) {
    let nextViewController = controller
    let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    keyWindow?.rootViewController = nextViewController
  }
	
	func createDataTask(urlString: String,
											param: [String: String]?,
											httpMethod: String,
											headerValues: [String: String]?,
											complition: @escaping (([String: AnyObject])->Void)) {
		guard var urlComponents = URLComponents(string: urlString) else { return }
		
		var items = [URLQueryItem]()
		if let parametres = param {
			for (key, value) in parametres {
				items.append(URLQueryItem(name: key, value: value))
			}
			urlComponents.queryItems = items
		}
		
		guard let url = urlComponents.url else { return }
		
		var request =  URLRequest(url: url)
		request.httpMethod = httpMethod
		
		if let headerValues = headerValues {
			for(key, value) in headerValues {
				request.setValue(value, forHTTPHeaderField: key)
			}
		}

	 
		
		let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard
				let data = data,
				error == nil
			else { return }

			do {
				guard
					let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
				else { return }

				DispatchQueue.main.async { 
					complition(json)
				}
			} catch {
				print(error)
			}
		}

		dataTask.resume()
	}
  
}
