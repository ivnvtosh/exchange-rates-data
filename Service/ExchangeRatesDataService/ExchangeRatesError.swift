//
//  ExchangeRatesError.swift
//  Test
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

/// A type representing an error value that can be thrown.
enum ExchangeRatesError: Error {
	
	/// Status code - 400
	///
	/// The request was unacceptable, often due to missing a required parameter.
	case badRequest
	
	/// Status code - 401
	///
	/// No valid API key provided.
	case unauthorized
	
	/// Status code - 404
	///
	/// The requested resource doesn't exist.
	case notFound
	
	/// Status code - 429
	///
	/// API request limit exceeded. See section Rate Limiting for more info.
	case tooManyRequests
	
	/// Status code - 5xx
	///
	/// We have failed to process your request. (You can contact us anytime)
	case serverError
	
	case statusCodeIsNot2xx(Int)
	
	case cannotParceResponse
	
	case failedToDecode(String)
	
	case isNotSuccess
}
