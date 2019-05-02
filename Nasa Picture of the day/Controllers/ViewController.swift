//
//  ViewController.swift
//  Nasa Picture of the day
//
//  Created by Давид on 01/05/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var photoInfo: PhotoInfo? {
        didSet {
            updateUI()
        }
    }
    // формируем адрес
    let url = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    let query = [
        "api_key":"DEMO_KEY",
        "date":"2019-02-14",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    func requestData() {
        PhotoInfoController.shared.fetchphotoinfo(url: url.withQueries(query)) { (photoInfo) in
            guard let photoInfo = photoInfo else { return }
            
            self.photoInfo = photoInfo
            
            PhotoInfoController.shared.fetchImage(url: photoInfo.url, completion: { (image) in
                guard let image = image else { return }
                
                DispatchQueue.main.async {
                    self.photoImage.image = image
                }
            })
        }
////        let url = self.url.withQueries(query)!
//        print(#function, url.absoluteString)
//
//        URLSession.shared.dataTask(with: url) { (data, respond, error) in // при отработеке url ролучаем 3 занчения, при этом данные опциональны
//            guard let data = data else {
//                print("Error in \(#function) on \(#line): cant read the data")
//                return
//
//            }
////            guard let string = String(data: data, encoding: .utf8) else { return } // расшифровка данных в текстовом виде(json)
////            print(#function, string)
//
//            let jsonDecorder = JSONDecoder()
//
//            guard let photoInfo = try? jsonDecorder.decode(PhotoInfo.self, from: data) else {
//                print("Error in \(#function) on \(#line): cant decode the data")
//                return
//            }
////            self.photoInfo = photoInfo
//            print(#function, photoInfo)
//        }.resume() // отправление задачи на выполнение
        
    }
    
    func updateUI() {
        guard let photoInfo = photoInfo else { return }
        
        // существует множество потоков и для пользовательского интерфейса выделяется поток с максимальным приоритетом
        DispatchQueue.main.async {
            self.titleLabel.text = photoInfo.title
            self.descriptionLabel.text = photoInfo.description
            self.copyrightLabel.text = photoInfo.copyright
        }
        
    }


}

