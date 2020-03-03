//
//  HTTPRequest.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation

public struct HTTPRequestHeaderField {
    let name: String
    let value: String
}

public protocol HTTPRequest {
    associatedtype Response: HTTPResponse
    typealias Method = HTTPRequestMethod
    typealias HeaderField = HTTPRequestHeaderField
    
    var url: URL { get }
    var method: Method { get }
    var headerFields: [HeaderField] { get }
    var data: Data? { get }
}

public protocol JSONRequest: HTTPRequest {
    associatedtype Body: Codable
    
    var body: Body? { get }
}

public extension JSONRequest {
    var data: Data? {
        return try? self.body.map(JSONEncoder().encode)
    }
}
