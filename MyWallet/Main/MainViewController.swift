//
//  MainViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 30/04/24.
//

import UIKit

final class MainViewController: UIViewController {

    enum MainViewControllerSection: Int, CaseIterable {
        case cards = 0
        case savedOperations = 1
        case exchangeRates = 2
        case quickPay = 3
    }
    
    let contextMenuItems = [
        ContextMenuItem(title: "Edit", image: UIImage.add, index: 0),
        ContextMenuItem(title: "Remove", image: UIImage.add, index: 1),
        ContextMenuItem(title: "Promote", image: UIImage.add, index: 2)
    ]
    
    struct ContextMenuItem {
      var title = ""
      var image = UIImage()
      var index = 0
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<MainViewControllerSection, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMonitoringButton()
        createCollectionView()
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
    
    func createCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "CardsContainerCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CardsContainerCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "SavedOperationCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "SavedOperationCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "SavedOperationCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "SavedOperationCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "ExchangeRatesWidgetCell", bundle: nil),
            forCellWithReuseIdentifier: "ExchangeRatesWidgetCell"
        )
        collectionView.register(
            UINib(nibName: "QuickPayWidgetCell", bundle: nil),
            forCellWithReuseIdentifier: "QuickPayWidgetCell"
        )
        collectionView.collectionViewLayout = createLayout()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.getCardsSectionLayout()
            }
            if sectionIndex == 1 {
                return self.getSavedOperationsSectionLayout()
            }
            if sectionIndex == 2 {
                return self.getExchangeRatesSectionLayout()
            }
            if sectionIndex == 3 {
                return self.getQuickPaySectionLayout()
            }
            return nil
        }
        return layout
    }
    
    func getCardsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)

        let groupHeight = NSCollectionLayoutDimension.absolute(54*4)
        let groupWidth = NSCollectionLayoutDimension.absolute(86*4)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: groupWidth,
            heightDimension: groupHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func getSavedOperationsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 10
        return section
    }
    
    func getExchangeRatesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 10
        return section
    }
    
    func getQuickPaySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.75)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 10
        return section
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        if section == 1 {
            return 10
        }
        if section == 2 {
            return 1
        }
        if section == 3 {
            return 1
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsContainerCollectionViewCell", for: indexPath) as? CardsContainerCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedOperationCollectionViewCell", for: indexPath) as? SavedOperationCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeRatesWidgetCell", for: indexPath) as? ExchangeRatesWidgetCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        if indexPath.section == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickPayWidgetCell", for: indexPath) as? QuickPayWidgetCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        fatalError()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.makeContextMenu(for: indexPath.row)
        })
    }
    
    func makeContextMenu(for index:Int) -> UIMenu {
        var actions = [UIAction]()
        for item in self.contextMenuItems {
            let action = UIAction(title: item.title, image: item.image, identifier: nil, discoverabilityTitle: nil) { _ in
                //self.didSelectContextMenu(menuIndex: item.index, cellIndex: index)  // Here I have both cell index & context menu item index
                print("did select at \(index)")
            }
            actions.append(action)
        }
        let cancel = UIAction(title: "Cancel", attributes: .destructive) { _ in}
        actions.append(cancel)
        return UIMenu(title: "", children: actions)
    }
    
}
