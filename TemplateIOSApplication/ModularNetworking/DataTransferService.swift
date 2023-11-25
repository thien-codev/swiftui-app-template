//
//  DataTransferService.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 06/11/2023.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void)
}

extension DispatchQueue: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        async(execute: work)
    }
}

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    func request<T: Decodable, R: ResponseRequestable>(with endpoint: R,
                                                       on queue: DataTransferDispatchQueue,
                                                       completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where R.Response == T
    
    func request<R: ResponseRequestable>(with endpoint: R,
                                         on queue: DataTransferDispatchQueue,
                                         completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where R.Response == Void
}

final class DefaultDataTransferService {
    
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    func request<T: Decodable, R: ResponseRequestable>(with endpoint: R, on queue: DataTransferDispatchQueue, completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where T == R.Response {
        service.request(endpoint: endpoint, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                queue.asyncExecute {
                    completion(result)
                }
            case let .failure(error):
                queue.asyncExecute {
                    completion(.failure(.networkFailure(error)))
                }
            }
        })
    }
    
    func request<R: ResponseRequestable>(with endpoint: R, on queue: DataTransferDispatchQueue, completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where R : ResponseRequestable, R.Response == () {
        service.request(endpoint: endpoint, completion: { result in
            switch result {
            case .success:
                queue.asyncExecute { completion(.success(())) }
            case .failure(let error):
                queue.asyncExecute { completion(.failure(.networkFailure(error))) }
            }
        })
    }
}

private extension DefaultDataTransferService {
    func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            if let data {
                let result: T = try decoder.decode(data)
                return .success(result)
            } else {
                return .failure(.noResponse)
            }
        } catch {
            return .failure(.parsing(error))
        }
    }
}
