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
    let segueToDetail = "toDetailNews"
    var selectNews: NewsItemData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        getNewsByCat()
        
        self.navigationItem.title = category.capitalized
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueToDetail else { return }
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let detailVC = navigationVC.viewControllers.first as? DetailNewsViewController else { return }
        
        detailVC.currentNews = selectNews
        detailVC.currentCategory = category
    }
}

extension CategoryCollectionViewController {
    // Получаем список новостей для текущей категории
    func getNewsByCat() {
        guard let url = URL(string: News.apiPath + category) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if response == nil || error != nil {
                self.showServerError()
            }
            
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
    
    // Сообщение об ошибке соединения к серверу
    func showServerError() {
        let alert = UIAlertController(title: "Error", message: "The server is unavailable", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectNews = categories[indexPath.item]
        
        performSegue(withIdentifier: segueToDetail, sender: nil)
    }
}
