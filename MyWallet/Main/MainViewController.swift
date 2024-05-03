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
        collectionView.collectionViewLayout = createLayout()
    }
    
    /// - Tag: PerSection
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.getCardsSectionLayout()
            }
            if sectionIndex == 1 {
                return self.getSavedOperationsSectionLayout()
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
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        if section == 1 {
            return 10
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
        
        fatalError()
        
    }
    
    
}
