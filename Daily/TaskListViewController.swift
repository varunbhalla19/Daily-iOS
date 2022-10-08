//
//  TaskListViewController.swift
//  Daily
//
//  Created by varunbhalla19 on 06/10/22.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var tasks: [Task] = Task.testData
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = listLayout()
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        updateSnapshot()
        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewLayout {
        var layout = UICollectionLayoutListConfiguration.init(appearance: .grouped)
        layout.backgroundColor = .clear
//        layout.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: layout)
    }
    
}


extension TaskListViewController {
    
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Task.ID>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Task.ID>

    func cellRegistrationHandler(cell: UICollectionViewListCell,
                                 indexPath: IndexPath, itemIdentifier: Task.ID) {
        var config = cell.defaultContentConfiguration()
        let task = task(for: itemIdentifier)
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
    
    func updateSnapshot(with ids: [Task.ID] = []){
        var snapShot = SnapShot.init()
        snapShot.appendSections([0])
        snapShot.appendItems(tasks.map({ $0.id }))
        if !ids.isEmpty {
            snapShot.reloadItems(ids)
        }
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    func doneButtonConfig(for task: Task) -> UICellAccessory.CustomViewConfiguration {
        
        let circle = task.isComplete ? "circle.fill": "circle"
        let imageConfig = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage.init(systemName: circle, withConfiguration: imageConfig)
        let btn = TaskDoneButton.init()
        btn.id = task.id
        btn.addTarget(self, action: #selector(didPressDone), for: .touchUpInside)
        btn.setImage(image, for: .normal)
        
        return .init(
            customView: btn,
            placement: .leading(displayed: .always)
        )
    }
    
    func task(for id: Task.ID) -> Task {
        tasks[tasks.indexForTask(with: id)]
    }
    
    func update(_ task: Task, with id: Task.ID) {
        let taskIndex = tasks.indexForTask(with: id)
        tasks[taskIndex] = task
        updateSnapshot(with: [id])
    }
    
    func complete(with id: Task.ID) {
        var currentTask = task(for: id)
        currentTask.isComplete.toggle()
        update(currentTask, with: id)
    }
    
}

extension TaskListViewController {
    
    @objc func didPressDone(_ sender: TaskDoneButton) {
        if let id = sender.id {
            complete(with: id)
        }
    }
    
}
