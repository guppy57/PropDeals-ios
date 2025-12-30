//
//  Helpers.swift
//  PropDeals-ios
//
//  Created on 12/30/24.
//

import Foundation

func formatCurrency(_ value: Double) -> String {
	let formatter = NumberFormatter()
	formatter.numberStyle = .currency
	formatter.maximumFractionDigits = 0
	return formatter.string(from: NSNumber(value: value)) ?? "$\(Int(value))"
}

func formatCurrency(_ value: Int) -> String {
	let formatter = NumberFormatter()
	formatter.numberStyle = .currency
	formatter.maximumFractionDigits = 0
	return formatter.string(from: NSNumber(value: value)) ?? "$\(value)"
}

func formatNumber(_ value: Double) -> String {
	let formatter = NumberFormatter()
	formatter.numberStyle = .decimal
	formatter.maximumFractionDigits = 0
	return formatter.string(from: NSNumber(value: value)) ?? "\(Int(value))"
}

func formatNumber(_ value: Int) -> String {
	let formatter = NumberFormatter()
	formatter.numberStyle = .decimal
	formatter.maximumFractionDigits = 0
	return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
}
