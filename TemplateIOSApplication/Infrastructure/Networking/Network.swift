//
//  Network.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 02/11/2023.
//

import Foundation
import Alamofire

enum ServiceError: Error {
    case invalidUrl
    case noResponse
    case timeout
}

protocol NetworkType {
    func request<T>(resource: Resource<T>, timeout: TimeInterval?) async throws -> T
}

extension NetworkType {
    func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("Error decoding: \(error)")
            return nil
        }
    }
}

class Network: NetworkType {
    func request<T>(resource: Resource<T>, timeout: TimeInterval? = nil) async throws -> T {
        
        Task {
            if let timeout {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1000))
                throw ServiceError.timeout
            }
        }
        
        return try await withCheckedThrowingContinuation({ continuation in
            load(resource: resource, completion: { continuation.resume(with: $0) })
        })
    }
}

private extension Network {
    func load<T>(resource: Resource<T>, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        guard let url = resource.endpoint.url else {
            completeOnMainQueue(completion, result: .failure(ServiceError.invalidUrl))
            return
        }
        AF.request(url, method: resource.method.alamofireMethod, parameters: resource.params)
            .validate()
            .response { [weak self] response in
                guard let self else { return }
                switch response.result {
                case let .failure(error):
                    self.completeOnMainQueue(completion, result: .failure(error))
                case let .success(data):
                    if let data, let parseHandler = resource.parseData {
                        let result = parseHandler(data)
                        self.completeOnMainQueue(completion, result: .success(result))
                    } else {
                        self.completeOnMainQueue(completion, result: .failure(ServiceError.noResponse))
                    }
                }
            }
    }
    
    func completeOnMainQueue<T>(_ completion: @escaping (Swift.Result<T, Error>) -> Void, result: Swift.Result<T, Error>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
