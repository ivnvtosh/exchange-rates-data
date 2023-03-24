//
//  main.swift
//  Main
//
//  Created by Anton Ivanov on 24.03.2023.
//

import Foundation

let path = NSHomeDirectory() + "/KeyExchangeRatesDataService.txt"

if let key = try? String(contentsOfFile: path) {
	
	let exchangeRatesDataService = ExchangeRatesDataService(key: key)
	let interactor = Interactor(exchangeRatesDataService: exchangeRatesDataService)
	
	let semaphore = DispatchSemaphore(value: 0)
	
	Task {
		
		do {
			
			let rates = try await interactor.load(currencies: "RUB, EUR, BDT", baseCurrency: "USD")
			
			print(rates)
			semaphore.signal()
		}
		
		catch {
			
			print(error)
			semaphore.signal()
		}
	}
	
	semaphore.wait()
}

else {
	
	print("Отсутствует файл с ключом:", path)
}
