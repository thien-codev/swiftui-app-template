//
//  Endpoint.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 05/11/2023.
//

import Foundation

typealias JSONDictionary = [String: Any]

struct Endpoint<T: Decodable>: ResponseRequestable {
    typealias Response = T
    
    let baseURL: String
    let path: String
    let method: HTTPMethodType
    let headers: [String : String]?
    let headerParamaters: [String : String]?
    let headerParamatersEncodable: Encodable?
    let queryParamaters: [String : String]
    let queryParamatersEncodable: Encodable?
    let bodyEncoder: BodyEncoder
    let responseDecoder: ResponseDecoder
    
    init(baseURL: String,
         path: String,
         method: HTTPMethodType = .get,
         headers: [String : String]? = nil,
         headerParamaters: [String : String]? = nil,
         headerParamatersEncodable: Encodable? = nil,
         queryParamaters: [String : String] = [:],
         queryParamatersEncodable: Encodable? = nil,
         bodyEncoder: BodyEncoder = JSONBodyEncoder(),
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.responseDecoder = responseDecoder
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.headerParamaters = headerParamaters
        self.headerParamatersEncodable = headerParamatersEncodable
        self.queryParamaters = queryParamaters
        self.queryParamatersEncodable = queryParamatersEncodable
        self.bodyEncoder = bodyEncoder
    }
}

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data?
}

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: [String: String]? { get }
    var headerParamaters: [String: String]? { get }
    var headerParamatersEncodable: Encodable? { get }
    var queryParamaters: [String: String] { get }
    var queryParamatersEncodable: Encodable? { get }
    var bodyEncoder: BodyEncoder { get }
    var responseDecoder: ResponseDecoder { get }
}

extension Requestable {
    
    var url: URL? {
        
        let urlString = baseURL.appending(path)
        
        var urlComponent = URLComponents(string: urlString)
        
        var querys = [URLQueryItem]()
        
        let queryParams = queryParamatersEncodable?.toDictionary() ?? queryParamaters
        
        querys.append(contentsOf: queryParams.compactMap({ URLQueryItem(name: "\($0.key)", value: "\($0.value)") }))
        
        urlComponent?.queryItems = querys
        
        return urlComponent?.url
    }
    
    var urlRequest: URLRequest? {
        guard let url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        let headerParams = headerParamatersEncodable?.jsonDict ?? headerParamaters
        if let headerParams {
            urlRequest.httpBody = bodyEncoder.encode(headerParams)
        }
        
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}

struct JSONBodyEncoder: BodyEncoder {
    func encode(_ parameters: [String : Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}

struct ASCIIBodyEncoder: BodyEncoder {
    func encode(_ parameters: [String : Any]) -> Data? {
        return parameters.queryString?.data(using: .ascii)
    }
}

enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONResponseDecoder: ResponseDecoder {
    let decoder = JSONDecoder()
    func decode<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}

private extension Encodable {
    func toDictionary() -> JSONDictionary? {
        do {
            let data = try JSONEncoder().encode(self)
            let josnData = try JSONSerialization.jsonObject(with: data)
            return josnData as? JSONDictionary
        } catch {
            return nil
        }
    }
}
