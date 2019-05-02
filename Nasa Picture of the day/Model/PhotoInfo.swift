//
//  PhotoInfo.swift
//  Nasa Picture of the day
//
//  Created by Давид on 02/05/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
//    var test: Test
    
    
    enum CodingKeys: String, CodingKey {    // заводим такой enum если поляв в json не совпадают с нашими переменными
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    
    init(from decoder: Decoder) throws { // сюда передается json и мы декодируем его данные
        // container содержит ключи, которые мы можем использовать для декодирования
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try valueContainer.decode(String.self, forKey: .title)
        description = try valueContainer.decode(String.self, forKey: .description)
        url = try valueContainer.decode(URL.self, forKey: .url)
        copyright = try? valueContainer.decode(String.self, forKey: .copyright)
    }
}

//struct Test: Codable {
//    var test: String
//}
