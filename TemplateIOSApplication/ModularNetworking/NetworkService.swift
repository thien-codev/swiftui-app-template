//
//  NetworkService.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 05/11/2023.
//

import Foundation

protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: CompletionHandler) -> NetworkCancellable?
}

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

protocol NetworkCancellable {
    func cancel()
}
