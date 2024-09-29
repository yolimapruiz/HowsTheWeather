//
//  URLSessionRequestMaker.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class URLSessionRequestMaker {
    func url(endpoint: String, baseUrl: String) -> URL? {
        let urlString = "\(baseUrl)\(endpoint)"
        return URL(string: urlString)
    }
}
