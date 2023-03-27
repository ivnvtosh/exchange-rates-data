//
//  Presenter.swift
//  Main
//
//  Created by Anton Ivanov on 26.03.2023.
//

import Foundation

final class Presenter {
	
	let interactor: Interactor
	
	var trackedCurrencies = "RUB, EUR, BDT"
	
	var baseCurrency = "USD"
	
	var timer: Timer?
	
	var timeInterval = 10.0
	
	var isCurrencyTracked = false
	
	init(interactor: Interactor) {
		
		self.interactor = interactor
	}
	
	func didLoad() {
		
		loadCurrencies()
	}
	
	func loadCurrencies() {
		
		Task { @MainActor in
			
			do {
				
				let rates = try await interactor.load(latest: trackedCurrencies, to: baseCurrency)
				
				if isCurrencyTracked == false {
					
					startCurrencyTracked()
				}
				
				print(rates)
				// view?.show(rates)
			}
			
			catch {
				
				cancelCurrencyTracked()
				
				print(error)
				// router.showAlert(with: error, andTryAgain: loadCurrencies)
			}
		}
	}
	
	func startCurrencyTracked() {
		
		isCurrencyTracked = true
		
		let timer = Timer(timeInterval: timeInterval,
						  target: self,
						  selector: #selector(refreshCurrency),
						  userInfo: nil,
						  repeats: true)
		
		RunLoop.current.add(timer, forMode: .common)
		
		self.timer = timer
	}
	
	@objc func refreshCurrency() {
		
		loadCurrencies()
	}
	
	func cancelCurrencyTracked() {
		
		isCurrencyTracked = false
		
		timer?.invalidate()
		timer = nil
	}
}
