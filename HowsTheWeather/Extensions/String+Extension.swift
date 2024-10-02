//
//  String+Extension.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 2/10/24.
//

import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
