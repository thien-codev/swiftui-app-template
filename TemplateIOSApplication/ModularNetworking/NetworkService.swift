//
//  NetworkService.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 05/11/2023.
//

import Foundation
import Alamofire

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ url: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable
}

protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable?
}

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

protocol NetworkCancellable {
    func doCancel()
}

extension Request: NetworkCancellable {
    func doCancel() {
        cancel()
    }
}

class DefaultNetworkService {
    private let session: NetworkSessionManager
    private var task: NetworkCancellable?
    
    init(session: NetworkSessionManager) {
        self.session = session
    }
}

extension DefaultNetworkService: NetworkService {
    func request(endpoint: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void) -> NetworkCancellable? {
        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(.urlGeneration))
            return nil
        }
        task?.doCancel()
        task = session.request(urlRequest, completion: { data, _, requestError in
            if let requestError {
                completion(.failure(.generic(requestError)))
            } else {
                completion(.success(data))
            }
        })
        
        return task
    }
}

class AFNetworkSessionManager: NetworkSessionManager {
    func request(_ url: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkCancellable {
        AF.request(url)
            .validate()
            .responseData { response in
            switch response.result {
            case let .success(data):
                completion(data, nil, nil)
            case let .failure(error):
                completion(nil, nil, error)
            }
        }
    }
}
