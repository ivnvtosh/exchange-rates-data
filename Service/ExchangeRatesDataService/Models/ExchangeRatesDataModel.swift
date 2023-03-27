//
//  ExchangeRatesDataModel.swift
//  exchangerates
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

struct ExchangeRatesDataModel: Codable {
	
	/// Returns true or false depending on whether or not your API request has succeeded.
	let isSuccess: Bool
	
	/// Returns the exact date and time (UNIX time stamp) the given rates were collected.
	let timeStamp: Int
	
	/// Returns the three-letter currency code of the base currency used for this request.
	let baseCurrency: String
	
	/// Returns the date for which historical rates were requested.
	let date: String
	
	/// Returns exchange rate data for the currencies you have requested.
	let rates: [String : Double]
	
	enum CodingKeys: String, CodingKey {
		
		case isSuccess = "success"
		case timeStamp = "timestamp"
		case baseCurrency = "base"
		case date
		case rates
	}
}
