//
//  ExchangeRatesDataService.swift
//  Test
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

class ExchangeRatesDataService {
	
	let key: String
	
	init(key: String) {
		
		self.key = key
	}
	
	/// Универсальный метод, который по запросу загружает JSON и десериализует его в модель.
	/// - Parameters:
	///     - T Decodable: Модель, которая будет десериализована из JSON
	///     - with request URLRequest: Сформированный запрос.
	/// - Returns: Результирующая модель.
	private func getModel<T: Decodable>(with request: URLRequest) async throws -> T {
		
		let data = try await data(for: request)
		
		return try decode(from: data)
	}
	
	/// Метод, который по запросу загружает JSON и проверят ответ
	/// - Parameters:
	///     - with request URLRequest: Запрос.
	/// - Returns: Последовательность битов - JSON.
	private func data(for request: URLRequest) async throws -> Data {
		
		let (data, response) = try await URLSession.shared.data(for: request)
		
		guard let response = response as? HTTPURLResponse else {
			
			throw ExchangeRatesError.cannotParceResponse
		}
		
		switch response.statusCode {
			
		case 200...299:
			break
			
		case 400:
			throw ExchangeRatesError.badRequest
			
		case 401:
			throw ExchangeRatesError.unauthorized
			
		case 404:
			throw ExchangeRatesError.notFound
			
		case 429:
			throw ExchangeRatesError.tooManyRequests
			
		case 500...599:
			throw ExchangeRatesError.serverError
			
		default:
			throw ExchangeRatesError.statusCodeIsNot2xx(response.statusCode)
		}
		
		return data
	}
	
	/// Универсальный метод, который десериализует данные в модель.
	/// - Parameters:
	///     - T Decodable: Модель, которая будет получна из JSON.
	///     - from data Data: Последовательность битов - JSON.
	/// - Returns: Результирующая модель.
	private func decode<T: Decodable>(from data: Data) throws -> T {
		
		do {
			
			return try JSONDecoder().decode(T.self, from: data)
		}
		
		catch {
			
			let body = String(data: data, encoding: .utf8) ?? "Unknown encoding"
			
			throw ExchangeRatesError.failedToDecode(body)
		}
	}
}

extension ExchangeRatesDataService: ExchangeRatesDataServiceProtocol {
	
	func get(latest currencies: String, base: String) async throws -> ExchangeRatesDataModel {
		
		let request = try URLRequestBuilder(base: "https://api.apilayer.com")
			.set(path: "/exchangerates_data/latest")
			.set(method: .get)
			.set(headers: ["apikey" : key])
			.set(parameter: URLQueryItem(name: "symbols", value: currencies))
			.set(parameter: URLQueryItem(name: "base", value: base))
			.set(cachePolicy: .returnCacheDataElseLoad)
			.set(timeoutInterval: 15.0)
			.build()
		
		return try await getModel(with: request)
	}
}
