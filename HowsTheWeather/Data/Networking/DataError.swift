//
//  DataError.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

enum DataError: Error {
    case dataError
    case decodingError
    case URLError
    case networkError
    case apiError
    case otherError(Error)
}
