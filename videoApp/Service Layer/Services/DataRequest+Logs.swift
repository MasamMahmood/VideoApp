//
//  DataRequest+Logs.swift
//  videoApp
//
//  Created by Olga Vorona on 28/10/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation
import Alamofire


extension DataRequest {

    public func log() -> Self {
        #if DEBUG
        return logRequest().logResponse()
        #else
        if PlatoonLogger.log.level == .info {
            return logRequest().logResponse()
        } else {
            return self
        }
        #endif
    }

    // MARK: - Request logging

    public func logRequest() -> Self {
        guard let method = request?.httpMethod, let path = request?.url?.absoluteString else {
            return self
        }
        var text = "\n\(method) \(path) \nHeaders: "
        if let headers = request?.allHTTPHeaderFields as? NSDictionary {
            text.append(headers.description)
        }
        if let data = request?.httpBody, let body = String(data: data, encoding: .utf8) {
            text.append("\nData: \"\(body)\"")
        }
        print(text)
        return self
    }

    // MARK: - Response logging

    public func logResponse() -> Self {
        return response { response in
            guard let code = response.response?.statusCode,
                let path = response.request?.url?.absoluteString else {
                return
            }
            let traceID = response.response?.allHeaderFields["x-trace-id"] ?? "no trace id - \(response.response?.allHeaderFields)"
            var text = "\nx-trace-id: \(traceID)\n \(code) \(path)"
            if let data = response.data, let body = String(data: data, encoding: .utf8) {
                text.append("\nData: \"\(body)\"")
            }
            print(text)
        }
    }

}
