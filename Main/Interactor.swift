//
//  Interactor.swift
//  Main
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

class Interactor {
	
	let exchangeRatesDataService: ExchangeRatesDataServiceProtocol
	
	init(exchangeRatesDataService: ExchangeRatesDataServiceProtocol) {
		
		self.exchangeRatesDataService = exchangeRatesDataService
	}
}

extension Interactor: InteractorInput {
	
	func load(currencies: String, baseCurrency: String) async throws -> [String : Double] {
		
		let model = try await exchangeRatesDataService.get(latest: currencies, baseCurrency: baseCurrency)
		
		guard model.isSuccess else {
			
			throw ExchangeRatesError.isNotSuccess
		}
		
		return model.rates
	}
}
