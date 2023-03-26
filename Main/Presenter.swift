//
//  Presenter.swift
//  Main
//
//  Created by Anton Ivanov on 26.03.2023.
//

import Foundation

final class Presenter {
	
	let interactor: Interactor
	
	var timer: Timer?
	
	var timeInterval = 10.0
	
	init(interactor: Interactor) {
		
		self.interactor = interactor
	}
	
	func didLoad() {
		
		startTimer()
		loadCurrencies()
	}
	
	func startTimer() {
		
		let timer = Timer(timeInterval: timeInterval,
						  target: self,
						  selector: #selector(refresh),
						  userInfo: nil,
						  repeats: true)
		
		RunLoop.current.add(timer, forMode: .common)
		
		self.timer = timer
	}
	
	@objc func refresh() {
		
		loadCurrencies()
	}
	
	func cancelTimer() {
		
		timer?.invalidate()
		timer = nil
	}
	
	func loadCurrencies() {
		
		Task { @MainActor in
			
			do {
				
				let rates = try await interactor.load(currencies: "RUB, EUR, BDT",
													  baseCurrency: "USD")
				
				print(rates)
				// view?.show(rates)
			}
			
			catch {
				
				cancelTimer()
				
				print(error)
				// router.showAlert(with: error, and: startTimer)
			}
		}
	}
}
