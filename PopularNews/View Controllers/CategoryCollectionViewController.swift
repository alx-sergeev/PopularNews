//
//  CategoryCollectionViewController.swift
//  PopularNews
//
//  Created by Сергеев Александр on 15.12.2021.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    let newsCell = "newsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCell, for: indexPath) as! CategoryNewsCell
    
        cell.backgroundColor = .blue
    
        return cell
    }
}
