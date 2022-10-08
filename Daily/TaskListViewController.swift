//
//  ViewController.swift
//  Daily
//
//  Created by varunbhalla19 on 06/10/22.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = listLayout()
        
    }

    private func listLayout() -> UICollectionViewLayout {
        var layout = UICollectionLayoutListConfiguration.init(appearance: .grouped)
        layout.backgroundColor = .clear
        layout.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: layout)
    }
    
}

