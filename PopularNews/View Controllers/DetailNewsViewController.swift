//
//  DetailNewsViewController.swift
//  PopularNews
//
//  Created by Сергеев Александр on 20.12.2021.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    
    // MARK: - Properties
    var currentNews: NewsItemData?
    var currentCategory: String? = "All"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let news = currentNews {
            category.text = currentCategory?.capitalized
            dateNews.text = news.date
            author.text = "Author: \(news.author ?? "Popular News")"
            titleNews.text = news.title
            textNews.text = news.content
            
            DispatchQueue.global().async {
                if let image = news.imageUrl,
                   let urlImage = URL(string: image),
                   let dataImage = try? Data(contentsOf: urlImage) {
                    DispatchQueue.main.async {
                        self.imageNews.image = UIImage(data: dataImage)
                    }
                }
            }
        }
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
