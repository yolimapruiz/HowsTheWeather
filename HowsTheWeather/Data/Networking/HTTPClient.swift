//
//  HTTPClient.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import UIKit

protocol HTTPClient {
    func makeRequest(endpoint: String, baseUrl: String) async -> Result<Data, DataError>
}


protocol HTTPClientImage {
    func downloadImage(from urlString: String) async -> Data?
}
