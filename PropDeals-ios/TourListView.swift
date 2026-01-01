//
//  TourListView.swift
//  PropDeals-ios
//
//  Created by Armaan Gupta on 12/26/25.
//

import SwiftUI

struct TourListResponse: Codable {
	let properties: [PropertyWithCalculations]
}

struct TourListView: View {
	@State var properties: [PropertyWithCalculations] = []

	var body: some View {
		List(properties) { property in
			NavigationLink {
				TourPropertyDetailView(property: property)
			} label: {
				Text(property.address1)
			}
		}
		.navigationTitle("Tour List")
		.overlay {
			if properties.isEmpty {
				ProgressView()
			}
		}
		.task {
			do {
				let url = URL(string: "https://propdeals-production.up.railway.app/properties/phase1/tour-list")!
				let (data, _) = try await URLSession.shared.data(from: url)

				// SQL date formatter for "yyyy-MM-dd" format
				let sqlDateFormatter: DateFormatter = {
					let formatter = DateFormatter()
					formatter.dateFormat = "yyyy-MM-dd"
					formatter.locale = Locale(identifier: "en_US_POSIX")
					formatter.timeZone = TimeZone(secondsFromGMT: 0)
					return formatter
				}()

				let decoder = JSONDecoder()
				// Removed .convertFromSnakeCase - PropertyWithCalculations has explicit CodingKeys
				decoder.dateDecodingStrategy = .formatted(sqlDateFormatter)
				let response = try decoder.decode(TourListResponse.self, from: data)

				properties = response.properties
			} catch {
				dump(error)
			}
		}
	}
}

// MARK: - Financial Line Item Component

struct FinancialLineItem: View {
	let label: String
	let value: Double?
	let valueType: ValueType

	enum ValueType {
		case income      // Green
		case cost        // Red
		case equity      // Blue
		case neutral     // Gray
		case cashFlow    // Green/Red based on value
	}

	var body: some View {
		HStack {
			Text(label)
				.foregroundColor(.secondary)
			Spacer()
			Text(formattedValue)
				.fontWeight(.medium)
				.foregroundColor(valueColor)
		}
	}

	private var formattedValue: String {
		guard let value = value else { return "N/A" }
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = 2
		return formatter.string(from: NSNumber(value: value)) ?? "N/A"
	}

	private var valueColor: Color {
		switch valueType {
		case .income:
			return .green
		case .cost:
			return .red
		case .equity:
			return .blue
		case .neutral:
			return .secondary
		case .cashFlow:
			guard let value = value else { return .secondary }
			return value >= 0 ? .green : .red
		}
	}
}

// MARK: - Tour Property Detail View

struct TourPropertyDetailView: View {
	let property: PropertyWithCalculations
	@State private var showingScreeningSheet = false

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				if let price = property.purchasePrice {
					Text(formatCurrency(price)).bold().font(.title)
				}
				HStack(spacing: 4) {
					if let beds = property.beds {
						Text("\(beds) beds")
					}
					if let baths = property.baths {
						Text("• \(String(format: "%.1f", baths)) baths")
					}
					if let sqft = property.squareFt {
						Text("• \(formatNumber(sqft)) sqft")
					}
					if let units = property.units {
						if (units == 0) {
							Text("• SFH")
						} else if (units == 2) {
							Text("• Duplex")
						} else if (units == 3) {
							Text("• Triplex")
						} else if (units == 4) {
							Text("• Fourplex")
						}
					}
				}
				.font(.subheadline)

				Divider()

				// Financials Section
				financialsSection(for: property)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding()
		}
		.navigationTitle(property.address1)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar(.hidden, for: .tabBar)
		.toolbar {
			ToolbarItemGroup(placement: .bottomBar) {
				// Left button - standalone
				Button(action: {
					showingScreeningSheet = true
				}) {
					Label("Screening", systemImage: "eye")
				}

				Spacer()

				// Middle buttons - grouped together in Liquid Glass capsule
				ControlGroup {
					Button(action: {
						print("DEBUG: Mark Toured tapped for property: \(property.address1)")
					}) {
						Label("Toured", systemImage: "checkmark.circle")
					}

					Button(action: {
						print("DEBUG: Add Note tapped for property: \(property.address1)")
					}) {
						Label("Note", systemImage: "note.text")
					}
				}

				Spacer()

				// Right button - standalone
				Button(action: {
					print("DEBUG: Share tapped for property: \(property.address1)")
				}) {
					Label("Share", systemImage: "square.and.arrow.up")
				}
			}
		}
		.sheet(isPresented: $showingScreeningSheet) {
			NavigationStack {
				PropertyScreeningView(property: property)
					.navigationBarTitleDisplayMode(.inline)
					.toolbar {
						ToolbarItem(placement: .cancellationAction) {
							Button("Done") {
								showingScreeningSheet = false
							}
						}
					}
			}
		}
	}

	// MARK: - Financials Section Helper

	@ViewBuilder
	private func financialsSection(for property: PropertyWithCalculations) -> some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Financials")
				.font(.title2)
				.fontWeight(.bold)

			quickEstimateSection(for: property)
			Divider()
			marketRentYear1Section(for: property)
			Divider()
			marketRentYear2Section(for: property)
		}
	}

	// MARK: - Quick Estimate Section

	private func quickEstimateSection(for property: PropertyWithCalculations) -> some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Quick Estimate")
				.font(.headline)
				.fontWeight(.semibold)

			FinancialLineItem(label: "Total Rent", value: property.totalRent, valueType: .income)
			FinancialLineItem(label: "Roommate Utilities", value: property.roommateUtilities, valueType: .income)

			Text("Operating Expenses")
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
				.padding(.top, 8)

			FinancialLineItem(label: "Vacancy Reserve", value: property.monthlyVacancyCosts, valueType: .cost)
			FinancialLineItem(label: "Repairs Reserve", value: property.monthlyRepairCosts, valueType: .cost)
			FinancialLineItem(label: "Property Taxes", value: property.monthlyTaxes, valueType: .cost)
			FinancialLineItem(label: "Insurance", value: property.monthlyInsurance, valueType: .cost)

			Text("Debt Service")
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
				.padding(.top, 8)

			FinancialLineItem(label: "Mortgage P&I", value: property.monthlyMortgage, valueType: .cost)
			if let mip = property.monthlyMip, mip > 0 {
				FinancialLineItem(label: "MIP/PMI", value: mip, valueType: .cost)
			}

			FinancialLineItem(label: "Owner Utilities", value: property.ownerUtilities, valueType: .cost)
			FinancialLineItem(label: "Amortization", value: property.ammoritizationEstimate, valueType: .equity)

			if let totalRent = property.totalRent, let opEx = property.operatingExpenses {
				let noi = totalRent - opEx
				FinancialLineItem(label: "Net Operating Income", value: noi, valueType: .neutral)
			}

			Divider()
			FinancialLineItem(label: "Monthly Cash Flow", value: property.monthlyCashFlow, valueType: .cashFlow)
				.font(.headline)
		}
	}

	// MARK: - Market Rent Year 1 Section

	private func marketRentYear1Section(for property: PropertyWithCalculations) -> some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Market Rent - Year 1 (House-Hacking)")
				.font(.headline)
				.fontWeight(.semibold)

			FinancialLineItem(label: "Market Rent", value: property.mrNetRentY1, valueType: .income)
			FinancialLineItem(label: "Roommate Utilities", value: property.roommateUtilitiesY1, valueType: .income)

			Text("Operating Expenses")
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
				.padding(.top, 8)

			FinancialLineItem(label: "Vacancy Reserve", value: property.mrMonthlyVacancyCosts, valueType: .cost)
			FinancialLineItem(label: "Repairs Reserve", value: property.mrMonthlyRepairCosts, valueType: .cost)
			FinancialLineItem(label: "Property Taxes", value: property.monthlyTaxes, valueType: .cost)
			FinancialLineItem(label: "Insurance", value: property.monthlyInsurance, valueType: .cost)

			Text("Debt Service")
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
				.padding(.top, 8)

			FinancialLineItem(label: "Mortgage P&I", value: property.monthlyMortgage, valueType: .cost)
			if let mip = property.monthlyMip, mip > 0 {
				FinancialLineItem(label: "MIP/PMI", value: mip, valueType: .cost)
			}

			FinancialLineItem(label: "Owner Utilities", value: property.ownerUtilitiesY1, valueType: .cost)
			FinancialLineItem(label: "Amortization", value: property.ammoritizationEstimate, valueType: .equity)
			FinancialLineItem(label: "Net Operating Income", value: property.mrMonthlyNOIY1, valueType: .neutral)
			Divider()
			FinancialLineItem(label: "Monthly Cash Flow", value: property.mrMonthlyCashFlowY1, valueType: .cashFlow)
				.font(.headline)
		}
	}

	// MARK: - Market Rent Year 2 Section

	private func marketRentYear2Section(for property: PropertyWithCalculations) -> some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Market Rent - Year 2 (Fully Rented)")
				.font(.headline)
				.fontWeight(.semibold)

			FinancialLineItem(label: "Market Rent", value: property.mrNetRentY2, valueType: .income)
			FinancialLineItem(label: "Roommate Utilities", value: property.roommateUtilitiesY2, valueType: .income)

			Text("Operating Expenses")
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
				.padding(.top, 8)

			FinancialLineItem(label: "Vacancy Reserve", value: property.mrMonthlyVacancyCosts, valueType: .cost)
			FinancialLineItem(label: "Repairs Reserve", value: property.mrMonthlyRepairCosts, valueType: .cost)
			FinancialLineItem(label: "Property Taxes", value: property.monthlyTaxes, valueType: .cost)
			FinancialLineItem(label: "Insurance", value: property.monthlyInsurance, valueType: .cost)

			Text("Debt Service")
				.font(.subheadline)
				.fontWeight(.medium)
				.foregroundColor(.secondary)
				.padding(.top, 8)

			FinancialLineItem(label: "Mortgage P&I", value: property.monthlyMortgage, valueType: .cost)
			if let mip = property.monthlyMip, mip > 0 {
				FinancialLineItem(label: "MIP/PMI", value: mip, valueType: .cost)
			}

			FinancialLineItem(label: "Owner Utilities", value: property.ownerUtilitiesY2, valueType: .cost)
			FinancialLineItem(label: "Amortization", value: property.ammoritizationEstimate, valueType: .equity)
			FinancialLineItem(label: "Net Operating Income", value: property.mrMonthlyNOIY2, valueType: .neutral)
			Divider()
			FinancialLineItem(label: "Monthly Cash Flow", value: property.mrMonthlyCashFlowY2, valueType: .cashFlow)
				.font(.headline)
		}
	}
}

#Preview {
	TourListView()
}
