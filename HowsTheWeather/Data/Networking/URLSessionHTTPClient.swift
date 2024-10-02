//
//  URLSessionHTTPClient.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import UIKit

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

extension URLSessionHTTPClient: HTTPClientImage {
    
    //function to download weather icon from url
    
    func downloadImage(from urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do{
            let (data, _) = try await session.data(from: url)
            return data
        } catch {
            print("Could't download weather icon: \(error.localizedDescription)")
            return nil
        }
    }
}
