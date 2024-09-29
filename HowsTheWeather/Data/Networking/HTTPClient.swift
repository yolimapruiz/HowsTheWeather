//
//  HTTPClient.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

protocol HTTPClient {
    func makeRequest(endpoint: String, baseUrl: String) async -> Result<Data, DataError>
}
