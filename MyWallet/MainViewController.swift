//
//  MainViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 30/04/24.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setMonitoringButton()
    }
    
    func setMonitoringButton() {
        let button = UIBarButtonItem(
            image: UIImage.init(systemName: "chart.pie"),
            style: .plain,
            target: self,
            action: #selector(monitoringButtonTapped)
        )
        navigationItem.setRightBarButton(button, animated: true)
    }

    @objc private func monitoringButtonTapped() {
        let vc = MonitoringViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
