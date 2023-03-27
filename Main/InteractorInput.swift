//
//  InteractorInput.swift
//  Main
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

protocol InteractorInput {
	
	func load(latest currencies: String,
			  to сurrency: String) async throws -> [String : Double]
}
