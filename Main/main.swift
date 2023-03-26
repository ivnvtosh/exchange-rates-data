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
	
	let presenter = Presenter(interactor: interactor)
	
	presenter.didLoad()
	
	RunLoop.main.run()
}

else {
	
	print("Отсутствует файл с ключом:", path)
}
