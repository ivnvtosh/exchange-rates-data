//
//  ExchangeRatesDataModel.swift
//  exchangerates
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

struct ExchangeRatesDataModel: Codable {
	
	let isSuccess: Bool
	
	let timeStamp: Int
	
	let baseCurrency: String
	
	let date: String
	
	let rates: [String : Double]
	
	enum CodingKeys: String, CodingKey {
		
		case isSuccess = "success"
		case timeStamp = "timestamp"
		case baseCurrency = "base"
		case date
		case rates
	}
}
