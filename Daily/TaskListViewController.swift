//
//  ViewController.swift
//  Daily
//
//  Created by varunbhalla19 on 06/10/22.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = listLayout()
        
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            var config = cell.defaultContentConfiguration()
            let task = Task.testData[indexPath.item]
            config.text = task.title
            cell.contentConfiguration = config
        }
        
        dataSource = DataSource.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapShot = SnapShot.init()
        snapShot.appendSections([0])
        snapShot.appendItems(Task.testData.map({ $0.title }))
        dataSource.apply(snapShot, animatingDifferences: true)
        
        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewLayout {
        var layout = UICollectionLayoutListConfiguration.init(appearance: .grouped)
        layout.backgroundColor = .clear
        layout.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: layout)
    }
    
}

