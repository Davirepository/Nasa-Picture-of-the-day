//
//  URL+Extension.swift
//  Nasa Picture of the day
//
//  Created by Давид on 01/05/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)//resolvingAgainstBaseURL является ли это полным адресом
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components?.url
    }
}
