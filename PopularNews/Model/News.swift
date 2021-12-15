//
//  News.swift
//  PopularNews
//
//  Created by Сергеев Александр on 15.12.2021.
//

import Foundation

struct News {
    static let apiPath = "https://inshortsapi.vercel.app/news?category=" // Путь для получения новостей
    
    // Список всех категорий новостей
    static func getCategories() -> [String] {
        return [
            "all",
            "national",
            "business",
            "sports",
            "world",
            "politics",
            "technology",
            "startup",
            "entertainment",
            "miscellaneous",
            "hatke",
            "science",
            "automobile",
        ]
    }
}
