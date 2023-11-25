//
//  Resource.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation
import Alamofire

//typealias JSONDictionary = [String: Any]

struct Resource<T> {
    
    let endpoint: URLExpected
    let method: MyMethod
    let params: JSONDictionary?
    let headers: HTTPHeaders?
    let thread: DispatchQueue
    let parseData: ((Data) -> T)?
    
    init(endpoint: URLExpected, method: MyMethod = .get, params: JSONDictionary? = nil, headers: HTTPHeaders? = nil, thread: DispatchQueue = .global(), parseData: ((Data) -> T)? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.params = params
        self.headers = headers
        self.thread = thread
        self.parseData = parseData
    }
}

enum MyMethod {
    case get
    case post(parameters: JSONDictionary)
    case put(parameters: JSONDictionary)
    case delete(parameters: JSONDictionary)
    case postData(parameters: JSONDictionary?)
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        case .postData:
            return .post
        }
    }
}

enum AnimalURL: URLExpected {
    
    case animals
    case animalDetail
    case imageSearch(params: String)
    case imageDetail(params: String)
    
    var baseUrlString: String { Bundle.main.plistValue(Bundle.Keys.animalBaseUrl) ?? .init() }
    
    var pathString: String {
        switch self {
        case .imageSearch:
            return "/v1/images/search?%@"
        case .imageDetail:
            return "/v1/images/%@"
        case .animals:
            return "/v1/images/search"
        case .animalDetail:
            return "/v1/images/"
        }
    }
    var url: URL? {
        URL(string: String(format: baseUrlString + pathString, requestParams))
    }
    
    private var requestParams: String {
        switch self {
        case .imageSearch(let params), .imageDetail(let params):
            return params
        case .animals:
            return ""
        case .animalDetail:
            return ""
        }
    }
}

protocol URLExpected {
    var baseUrlString: String { get }
    var pathString: String { get }
    var url: URL? { get }
}
