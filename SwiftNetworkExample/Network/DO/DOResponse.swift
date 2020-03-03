//
//  DOResponse.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/03/02.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation

public struct DOResponse<BodyData: Codable>: JSONResponse {
    public struct Body: Codable {
        public let message: String
        public let code: String
        public let __go_checksum__: Bool
        public let data: BodyData?
        public let name: String?
    }
    
    public let statusCode: Int
    public let data: Data
    
    public init(from data: Data, with statusCode: Int) {
        self.data = data
        self.statusCode = statusCode
    }
}

