//
//  HTTPResponse.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation

public protocol HTTPResponse {
    typealias Status = HTTPResponseStatus
    
    var statusCode: Int { get }
    var data: Data { get }
    
    init(from data: Data, with statusCode: Int)
}

public extension HTTPResponse {
    var status: Status {
        return .create(from: self.statusCode)
    }
}

public protocol JSONResponse: HTTPResponse {
    associatedtype Body: Codable
}

public extension JSONResponse {
    var body: Body? {
        do {
            return try JSONDecoder().decode(Body.self, from: self.data)
        }
        catch {
            return nil
        }
    }
}
