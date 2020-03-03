//
//  URLClient.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation
import RxSwift

class URLClient: HTTPClient {
    
    func submit<Request: HTTPRequest>(_ request: Request) -> Single<Request.Response> {
        return .create { (singleEventConsumer) in
            let urlRequest: URLRequest = self.createURLRequest(from: request)

            let urlSession: URLSession = .init(configuration: .default)
            
            let urlSessionDataTask: URLSessionDataTask = urlSession.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
                if let data = data, let urlResponse = urlResponse as? HTTPURLResponse {
                    let response: Request.Response = .init(from: data, with: urlResponse.statusCode)
                    singleEventConsumer(.success(response))
                }
                else if let error = error {
                    singleEventConsumer(.error(error))
                }
                else {
                    singleEventConsumer(.error(RxError.noElements))
                }
            })
            
            urlSessionDataTask.resume()
            
            return Disposables.create {
                urlSessionDataTask.cancel()
            }
        }
    }
    
    private func createURLRequest<Request: HTTPRequest>(from httpRequest: Request) -> URLRequest {
        var urlRequest: URLRequest = .init(url: httpRequest.url)
        
        urlRequest.httpMethod = httpRequest.method.description
        
        httpRequest.headerFields.forEach { (headerField) in
            urlRequest.addValue(headerField.value, forHTTPHeaderField: headerField.name)
        }
        
        urlRequest.httpBody = httpRequest.data
        
        return urlRequest
    }
}
