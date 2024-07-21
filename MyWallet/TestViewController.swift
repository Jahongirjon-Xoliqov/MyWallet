//
//  TestViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 03/03/24.
//

import UIKit

class TestViewController: UIViewController {

    private let tableView: UITableView = {
        UITableView()
    }()
    
    private enum SectionData {
        case first
        case second
    }
    
    private struct ItemData: Hashable {
        var text: String
    }
    
    private var dataSource: UITableViewDiffableDataSource<SectionData, ItemData>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
