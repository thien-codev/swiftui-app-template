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
    
    let responseDecoder: ResponseDecoder
    let baseURL: String
    let path: String
    let method: HTTPMethodType
    let headers: [String : String]
    let headerParamaters: [String : String]
    let headerParamatersEncodable: Encodable?
    let queryParamaters: [String : String]
    let queryParamatersEncodable: Encodable?
    let bodyEncoding: BodyEncoding
    
    init(responseDecoder: ResponseDecoder, 
         baseURL: String,
         path: String,
         method: HTTPMethodType,
         headers: [String : String],
         headerParamaters: [String : String],
         headerParamatersEncodable: Encodable?,
         queryParamaters: [String : String],
         queryParamatersEncodable: Encodable?,
         bodyEncoding: BodyEncoding) {
        self.responseDecoder = responseDecoder
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.headerParamaters = headerParamaters
        self.headerParamatersEncodable = headerParamatersEncodable
        self.queryParamaters = queryParamaters
        self.queryParamatersEncodable = queryParamatersEncodable
        self.bodyEncoding = bodyEncoding
    }
}

extension Endpoint {
    
}

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: [String: String] { get }
    var headerParamaters: [String: String] { get }
    var headerParamatersEncodable: Encodable? { get }
    var queryParamaters: [String: String] { get }
    var queryParamatersEncodable: Encodable? { get }
    var bodyEncoding: BodyEncoding { get }
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
