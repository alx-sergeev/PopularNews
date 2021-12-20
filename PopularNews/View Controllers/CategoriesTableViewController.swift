//
//  CategoriesTableViewController.swift
//  PopularNews
//
//  Created by Сергеев Александр on 15.12.2021.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    // MARK: - Properties
    let categoryCell = "categoryCell"
    let categorySegue = "toCategory"
    let categories = News.getCategories()
    var currentCategory = "all"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == categorySegue else { return }
        guard let categoryVC = segue.destination as? CategoryCollectionViewController else { return }
        
        categoryVC.category = currentCategory
    }
    
}

extension CategoriesTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath)
        var cellConfiguration = cell.defaultContentConfiguration()
        
        cellConfiguration.text = categories[indexPath.row]
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        currentCategory = categories[indexPath.row]
        
        performSegue(withIdentifier: categorySegue, sender: nil)
    }
}
