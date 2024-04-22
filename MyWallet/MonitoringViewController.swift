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
    
    let yesNoViewModel = YesNoViewModel()
    let personViewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        executeAfterTokenCheck {
            self.personViewModel.request(isRefresh: true)
            self.yesNoViewModel.request(isRefresh: false)
            self.yesNoViewModel.request(isRefresh: false)
        }
        
    }
    
    func executeAfterTokenCheck(completion: @escaping () -> ()) {
        TokenManager.shared.makeTokenRefreshRequestIfNeededAndObserve {
            completion()
        }
    }
    
    @objc func tokenDidUpdate() {
        personViewModel.request(isRefresh: true)
        yesNoViewModel.request(isRefresh: false)
        yesNoViewModel.request(isRefresh: false)
    }
    
}


class YesNoViewModel {
    let yesnoURL = URL(string: "https://yesno.wtf/api")!
    var completion: (() -> ())?
    func request(isRefresh: Bool) {
        APIManager.shared.request(url: yesnoURL, isTokenRefresh: isRefresh) {
            print("yes no is done")
            self.completion?()
        }
    }
}

class PersonViewModel {
    let personURL = URL(string: "https://thispersondoesnotexist.com")!
    var completion: (() -> ())?
    func request(isRefresh: Bool) {
        APIManager.shared.request(url: personURL, isTokenRefresh: isRefresh) {
            print("person is done")
            self.completion?()
        }
    }
}

class APIManager {
    static let shared = APIManager()
    private var serialQueue = OperationQueue()
    
    private init() {}
    func request(url: URL, isTokenRefresh: Bool, completion: @escaping () -> ()) {
        
        serialQueue.addOperation {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { _, _, _ in
                completion()
                if isTokenRefresh {
                    
                }
            }
            task.resume()
        }
    }
}
var notificationName: NSNotification.Name = .init("token.refresh")
class TokenManager {
    static let shared = TokenManager()
    private init() {}
    private var isRefreshNeeded: Bool {
        UserDefaultsBacked<Bool>(key: "token", defaultValue: false).wrappedValue
    }
    private var refreshTask: URLSessionDataTask = {
        let urlRequest = URLRequest(url: URL(string: "https://thispersondoesnotexist.com")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { _, _, _ in
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        return task
    }()
    
    func execute(observer: Any, selector: Selector) {
        if isRefreshNeeded {
            if refreshTask.state == .running {
                //add
                add(observer, selector)
            }
            if refreshTask.state == .suspended {
                refreshTask.resume()
                //add
                add(observer, selector)
            }
            if refreshTask.state == .completed {
                refreshTask.resume()
                //add
                add(observer, selector)
            }
            return
        }
        //publish
        add(observer, selector)
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    func add(_ observer: Any, _ selector: Selector) {
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: notificationName,
                                               object: nil)
    }
    
}
