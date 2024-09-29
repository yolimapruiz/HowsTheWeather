//
//  URLSessionHTTPClient.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private let requestMaker: URLSessionRequestMaker
    
    init(session: URLSession = .shared, requestMaker: URLSessionRequestMaker) {
        self.session = session
        self.requestMaker = requestMaker
    }
    
    func makeRequest(endpoint: String, baseUrl: String) async -> Result<Data, DataError> {
        guard let url = requestMaker.url(endpoint: endpoint, baseUrl: baseUrl) else {
            return .failure(.URLError)
        }
        
        do {
            let result = try await session.data(from: url)
            
            guard let response = result.1 as? HTTPURLResponse else {
                return .failure(.networkError)
            }
            
            guard response.statusCode == 200 else {
                return .failure(.apiError)
            }
            
            return .success(result.0)
            
        } catch {
            
            return .failure(.otherError(error))
        }
    }
    
    
}
