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
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<MainViewControllerSection, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMonitoringButton()
        createCollectionView()
        configureDataSource()
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
    }
    
    private func configureDataSource() {
        
        if #available(iOS 14.0, *) {
            let cardsContainerCellRegistration = UICollectionView.CellRegistration<CardsContainerCollectionViewCell, Int> { (cell, indexPath, identifier) in
                // Populate the cell with our item description.
                cell.contentView.backgroundColor = .lightGray
            }
            
            let savedOperationsCellRegistration = UICollectionView.CellRegistration<SavedOperationCollectionViewCell, Int> { (cell, indexPath, identifier) in
                cell.contentView.backgroundColor = .systemGreen
            }
            
            dataSource = UICollectionViewDiffableDataSource<MainViewControllerSection, Int>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
                // Return the cell.
                return MainViewControllerSection(rawValue: indexPath.section)! == .cards ?
                collectionView.dequeueConfiguredReusableCell(using: cardsContainerCellRegistration, for: indexPath, item: identifier) :
                collectionView.dequeueConfiguredReusableCell(using: savedOperationsCellRegistration, for: indexPath, item: identifier)
            }
            
            // initial data
            let itemsPerSection = 10
            var snapshot = NSDiffableDataSourceSnapshot<MainViewControllerSection, Int>()
            MainViewControllerSection.allCases.forEach {
                snapshot.appendSections([$0])
                switch $0 {
                case .cards:
                    snapshot.appendItems([1, 2, 3, 4], toSection: $0)
                case .savedOperations:
                    snapshot.appendItems([5, 6, 7, 8, 9], toSection: $0)
                }
            }
            collectionView.collectionViewLayout = createLayout()
            dataSource.apply(snapshot, animatingDifferences: false)
        }
        
    }
    
    /// - Tag: PerSection
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionLayoutKind = MainViewControllerSection(rawValue: sectionIndex) else { return nil }
            
            switch sectionLayoutKind {
            case .cards:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // if we have the space, adapt and go 2-up + peeking 3rd item
                let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
                    0.425 : 0.85)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                                      heightDimension: .absolute(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 20
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(44))
                
                return section
                
            case .savedOperations:
                
                let columns = 1

                // The group auto-calculates the actual item width to make
                // the requested number of columns fit, so this widthDimension is ignored.
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                                     heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

                let section = NSCollectionLayoutSection(group: group)
                //section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                return section
                
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: lay,
            configuration:config)
        return layout
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
}
