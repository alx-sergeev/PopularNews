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
        }
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
