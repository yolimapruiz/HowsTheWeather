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

extension DataError: Equatable {
    static func == (lhs: DataError, rhs: DataError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
        && lhs.description == rhs.description
    }
}

extension DataError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .dataError:
            return "Please enter a valid city 🚫"
        case .decodingError:
            return "Decoding error: Unable to decode the response."
        case .URLError:
            return "URL error: The URL is invalid or unreachable."
        case .networkError:
            return "Network error: Unable to connect to the internet."
        case .apiError:
            return "API error: The server responded with an error."
        case .otherError(let error):
            return "Other error: \(error.localizedDescription)"
        }
    }
}
