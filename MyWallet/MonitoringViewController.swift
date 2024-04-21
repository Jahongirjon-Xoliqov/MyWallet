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
        
        
//        let firstTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
//            print("first task is completed")
//        }
//        firstTask.priority = 0.5
//        firstTask.resume()
//        
//        let secondTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
//            print("second task is completed")
//        }
//        secondTask.priority = 0.5
//        secondTask.resume()
//        
//        
//        let thirdTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
//            print("third task is completed")
//        }
//        thirdTask.priority = 0.5
//        thirdTask.resume()
//        
//        let importantTask = session!.dataTask(with: URLRequest(url: baseURL)) { _, _, _ in
//            print("important task is completed")
//            
//        }
//        importantTask.priority = 1
//        importantTask.resume()
//        
        var ss = UserDefaultsBacked<Bool>(key: "token", defaultValue: true)
        ss.wrappedValue = true
        TokenManager.shared.request {
            URLSession.shared.dataTask(with: URLRequest(url: self.baseURL)) { _, _, _ in
                print("first task is completed")
            }
            
            URLSession.shared.dataTask(with: URLRequest(url: self.baseURL)) { _, _, _ in
                print("second task is completed")
            }
            
            URLSession.shared.dataTask(with: URLRequest(url: self.baseURL)) { _, _, _ in
                print("third task is completed")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("////")
            TokenManager.shared.request {
                URLSession.shared.dataTask(with: URLRequest(url: self.baseURL)) { _, _, _ in
                    print("//// first task is completed")
                }
                
                URLSession.shared.dataTask(with: URLRequest(url: self.baseURL)) { _, _, _ in
                    print("//// second task is completed")
                }
                
                URLSession.shared.dataTask(with: URLRequest(url: self.baseURL)) { _, _, _ in
                    print("//// third task is completed")
                }
            }
        }
        
    }
    
}

@resultBuilder
struct URLSessionBuilder {
    static func buildBlock(_ contents: URLSessionDataTask...) -> [URLSessionDataTask] {
        contents
    }
}

final class TokenManager {
    static let shared = TokenManager()
    private var refreshTask: URLSessionDataTask?
    private var defaultConcurrentOperations = OperationQueue.defaultMaxConcurrentOperationCount
    private var serialQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    private var requiresTokenRefresh: Bool {
        UserDefaultsBacked<Bool>(key: "token", defaultValue: true).wrappedValue
    }
    private init() {}
    func request(@URLSessionBuilder _ contents: () -> [URLSessionDataTask]) {
        let tasks = contents()
        guard requiresTokenRefresh else {
            self.serialQueue.maxConcurrentOperationCount = defaultConcurrentOperations
            tasks.forEach { task in
                self.serialQueue.addOperation {
                    task.resume()
                }
            }
            return
        }
        
        if refreshTask == nil {
            refreshTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://yesno.wtf/api")!)) { _, _, _ in
                print("refresh is done")
                var ss = UserDefaultsBacked<Bool>(key: "token", defaultValue: true)
                ss.wrappedValue = false
            }
            serialQueue.addOperation {
                self.refreshTask?.resume()
            }
            serialQueue.addOperation {
                self.serialQueue.maxConcurrentOperationCount = 10
            }
            tasks.forEach { task in
                self.serialQueue.addOperation {
                    task.resume()
                }
            }
        }
        
        guard refreshTask?.state == .running else {
            tasks.forEach { $0.resume() }
            return
        }
        
        tasks.forEach { task in
            self.serialQueue.addOperation {
                task.resume()
            }
        }
        
    }
    
}
