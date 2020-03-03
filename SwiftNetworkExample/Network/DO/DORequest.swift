//
//  DORequest.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/03/02.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation

public enum DORequestConfiguration {
    public static var baseURL: URL? = nil
    public static let defaultBaseURL: URL = URL(string: "https://portal.daou.co.kr")!
}

public protocol DORequest: JSONRequest where Response == DOResponse<ResponseBodyData> {
    typealias Configuration = DORequestConfiguration
    associatedtype ResponseBodyData: Codable
    
    var path: String { get }
}

public extension DORequest {
    var baseURL: URL {
        return Configuration.baseURL ?? Configuration.defaultBaseURL
    }
    
    var url: URL {
        return self.baseURL.appendingPathComponent(self.path)
    }
    
    var headerFields: [HeaderField] {
        return [.init(name: "Content-Type", value: "application/json")]
    }
}
