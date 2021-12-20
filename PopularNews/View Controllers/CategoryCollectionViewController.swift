//
//  CategoryCollectionViewController.swift
//  PopularNews
//
//  Created by Сергеев Александр on 15.12.2021.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    let newsCell = "newsCell"
    var category = "all"
    var categories = [NewsItemData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        getNewsByCat()
    }
}

extension CategoryCollectionViewController {
    // Получаем список новостей для текущей категории
    func getNewsByCat() {
        guard let url = URL(string: News.apiPath + category) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { return }
            
            guard
                let data = data,
                let decodeData = try? JSONDecoder().decode(NewsData.self, from: data)
                else { return }
            
            self.categories = decodeData.data
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        
        task.resume()
    }
}

extension CategoryCollectionViewController {
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCell, for: indexPath) as! CategoryNewsCell
        
        cell.titleNews.text = categories[indexPath.row].title
        cell.categoryNews.text = category
        cell.dateTimeNews.text = categories[indexPath.row].date
        
        if let imageUrlProp = categories[indexPath.row].imageUrl {
            DispatchQueue.global().async {
                if let url = URL(string: imageUrlProp), let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.imageNews.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
}
