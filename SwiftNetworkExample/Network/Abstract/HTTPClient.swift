//
//  HTTPClient.swift
//  SwiftNetworkExample
//
//  Created by 전건우 on 2020/02/28.
//  Copyright © 2020 전건우. All rights reserved.
//

import Foundation
import RxSwift

protocol HTTPClient {
    func submit<Request: HTTPRequest>(_ request: Request) -> Single<Request.Response>
}
