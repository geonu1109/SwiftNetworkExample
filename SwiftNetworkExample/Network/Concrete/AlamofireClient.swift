//
//  AlamofireClient.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest: ReactiveCompatible {}

extension Reactive where Base: DataRequest {
    func responseJSON(queue: DispatchQueue = .main,
    options: JSONSerialization.ReadingOptions = .allowFragments) -> Single<AFDataResponse<Any>> {
        return .create { (singleEventListener) in
            self.base.responseJSON(queue: queue, options: options, completionHandler: { (response) in
                singleEventListener(.success(response))
            })
            return Disposables.create {
                self.base.cancel()
            }
        }
    }
}

class AlamofireClient: HTTPClient {
    func submit<Request: HTTPRequest>(_ request: Request) -> Single<Request.Response> {
        let parameters: Parameters? = request.data.flatMap { (data) in
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Parameters
        }
        
        return AF.request(request.url, method: .init(rawValue: request.method.description), parameters: parameters, encoding: JSONEncoding.default, headers: .init(request.headerFields.map { HTTPHeader(name: $0.name, value: $0.value) }), interceptor: nil).rx.responseJSON().map { (response) in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .sortedKeys)
                    guard let statusCode: Int = response.response?.statusCode else {
                        throw RxError.noElements
                    }
                    return .init(from: data, with: statusCode)
                }
                catch {
                    throw error
                }
            case .failure(let error):
                throw error
            }
        }
    }
}
