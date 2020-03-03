//
//  LoginRequest.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/03/02.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation

struct LoginRequest: DORequest {
    typealias Response = DOResponse<ResponseBodyData>
    
    struct Body: Codable {
        let username: String
        let password: String
    }
    
    struct ResponseBodyData: Codable {
        let redirect: String
        let xmppDomain: String
        let useSkipPwdChange: Bool
    }
    
    let path: String = "api/login"
    
    let method: HTTPRequest.Method = .post
    
    let body: Body?
    
    init(username: String, password: String) {
        self.body = .init(username: username, password: password)
    }
}
