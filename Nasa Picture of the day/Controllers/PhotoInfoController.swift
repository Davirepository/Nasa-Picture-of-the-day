//
//  PhotoInfoController.swift
//  Nasa Picture of the day
//
//  Created by Давид on 02/05/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class PhotoInfoController {
    
    // делаем для того чтобы никто не мог инициализировать PhotoInfoController напрямую, кроме нас самих(singleton)
    static let shared = PhotoInfoController()
    
    private init() {}
    
    // функция для выкачивания информации
    // в параметры передаем замыкание которое выполнится когда нам нужно будет получить данные
    // после того как отработает  url  в замыкание передастся либо нил либо фотоинфо
    func fetchphotoinfo(url: URL?, completion: @escaping (PhotoInfo?) -> Void) {
        
        guard let url = url else {
            print("Error in \(#function) on \(#line): URL is nil")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, respond, error) in // при отработеке url ролучаем 3 занчения, при этом данные опциональны
            guard let data = data else {
                print("Error in \(#function) on \(#line): cant read the data")
                completion(nil)
                return
                
            }
            
            let jsonDecorder = JSONDecoder()
            
            guard let photoInfo = try? jsonDecorder.decode(PhotoInfo.self, from: data) else {
                print("Error in \(#function) on \(#line): cant decode the data")
                completion(nil)
                return
            }
            completion(photoInfo)
            }.resume() // отправление задачи на выполнение
    }
    
    // функция возвращения картинки
    func fetchImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            print("Error in \(#function) on \(#line): URL is nil")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, respond, error) in // при отработеке url ролучаем 3 занчения, при этом данные опциональны
            guard let data = data else {
                print("Error in \(#function) on \(#line): cant read the data")
                completion(nil)
                return
                
            }
            
            // конструктор для создания картинки
            guard let image = UIImage(data: data) else {
                print("Error in \(#function) on \(#line): cant decode the image")
                completion(nil)
                return
            }
            
            completion(image)

            }.resume() // отправление задачи на выполнение
    }
}
