//
//  HTTPRequestMethod.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation

public enum HTTPRequestMethod: String, Equatable, CustomStringConvertible {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
    case patch = "PATCH"
    case unknown = "Unknown"
    
    public var description: String {
        return self.rawValue
    }
    
    public static func create(from text: String) -> HTTPRequestMethod {
        return HTTPRequestMethod(rawValue: text.uppercased()) ?? .unknown
    }
}
