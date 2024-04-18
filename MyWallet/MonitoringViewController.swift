//
//  MonitoringViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 03/03/24.
//

import UIKit

final class MonitoringViewController: UIViewController {
    
    let baseURL = URL(string: "https://yesno.wtf/api")!
    let personURL = URL(string: "https://thispersondoesnotexist.com")!
    var session: URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 1
        
        session = URLSession(configuration: config)
        
        let importantTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
            print("important task is completed")
            
        }
        importantTask.priority = 1
        importantTask.resume()
        
        let firstTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
            print("first task is completed")
        }
        firstTask.priority = 0.5
        firstTask.resume()
        
        let secondTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
            print("second task is completed")
        }
        secondTask.priority = 0.5
        secondTask.resume()
        
        
        let thirdTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
            print("third task is completed")
        }
        thirdTask.priority = 0.5
        thirdTask.resume()
        
    }
    
}
