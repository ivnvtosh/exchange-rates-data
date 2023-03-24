//
//  InteractorInput.swift
//  Main
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

protocol InteractorInput {
	
	func load(currencies: String, baseCurrency: String) async throws -> [String : Double]
}
