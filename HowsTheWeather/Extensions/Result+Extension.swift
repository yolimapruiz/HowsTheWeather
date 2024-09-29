//
//  Result+Extension.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

extension Result {
    var failureCase: Error? {
        switch self {
            
        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}
