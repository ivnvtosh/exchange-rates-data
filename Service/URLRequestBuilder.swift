//
//  URLRequestBuilder.swift
//  exchangerates
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

class URLRequestBuilder {
	
	let base: String
	
	var path = ""
	
	var method = HTTPMethod.get
	
	var headers = [String: Any]()
	
	var parameters = [URLQueryItem]()
	
	enum HTTPMethod: String {
		
		case get = "GET"
	}
	
	init(base: String) {
		
		self.base = base
	}
	
	@discardableResult
	func set(path: String) -> Self {
		
		self.path = path
		
		return self
	}
	
	@discardableResult
	func set(method: HTTPMethod) -> Self {
		
		self.method = method
		
		return self
	}
	
	@discardableResult
	func set(headers: [String: Any]) -> Self {
		
		self.headers = headers
		return self
	}
	
	@discardableResult
	func set(parameter: URLQueryItem) -> Self {
		
		parameters.append(parameter)
		
		return self
	}
	
	func build() throws -> URLRequest {
		
		var components = URLComponents(string: base)
		
		components?.path = path
		components?.queryItems = parameters
		
		guard let url = components?.url else {
			
			throw URLError(.badURL)
		}
		
		var request = URLRequest(url: url,
								 cachePolicy: .returnCacheDataElseLoad,
								 timeoutInterval: 10)
		
		request.httpMethod = method.rawValue
		
		headers.forEach { request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
		
		return request
	}
}
