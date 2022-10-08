//
//  TaskListViewController.swift
//  Daily
//
//  Created by varunbhalla19 on 06/10/22.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = listLayout()
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
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


extension TaskListViewController {
    
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>

    func cellRegistrationHandler(cell: UICollectionViewListCell,
                                 indexPath: IndexPath, itemIdentifier: String) {
        var config = cell.defaultContentConfiguration()
        let task = Task.testData[indexPath.item]
        config.text = task.title
        config.secondaryText = task.dueDate.dateTimeString
        config.secondaryTextProperties.font = .preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = config
        
        var doneButtonConfig = doneButtonConfig(for: task)
        doneButtonConfig.tintColor = .systemIndigo
        cell.accessories = [
            .customView(configuration: doneButtonConfig),
            .disclosureIndicator(displayed: .always)
        ]
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .systemGray6
        cell.backgroundConfiguration = backgroundConfig
    }
    
    func doneButtonConfig(for task: Task) -> UICellAccessory.CustomViewConfiguration {
        
        let circle = task.isComplete ? "circle.fill": "circle"
        let imageConfig = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage.init(systemName: circle, withConfiguration: imageConfig)
        let btn = UIButton.init()
        btn.setImage(image, for: .normal)
        
        return .init(
            customView: btn,
            placement: .leading(displayed: .always)
        )
    }
    
}
