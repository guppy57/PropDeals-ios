//
//  PropertyDetailView.swift
//  PropDeals-ios
//
//  Created by Claude on 12/26/25.
//

import SwiftUI

struct PropertyDetailView: View {
	let property: Property

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				// Header Section
				headerSection

				Divider()

				// Financial Summary
				financialSection

				Divider()

				// Property Features
				featuresSection

				Divider()

				// Location Scores
				scoresSection

				// Risk Flags (only if any exist)
				if hasRiskFlags {
					Divider()
					riskFlagsSection
				}

				// Zillow Link
				if let zillowLink = property.zillowLink {
					Divider()
					zillowLinkSection(url: zillowLink)
				}
			}
			.padding()
		}
		.navigationTitle("Property Details")
	}

	// MARK: - Header Section

	private var headerSection: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(property.fullAddress ?? property.address1)
				.font(.title2)
				.fontWeight(.bold)

			HStack {
				statusBadge

				if let county = property.county {
					Text(county)
						.font(.subheadline)
						.foregroundColor(.secondary)
				}
			}
		}
	}

	private var statusBadge: some View {
		Text(property.status.rawValue.capitalized)
			.font(.caption)
			.fontWeight(.semibold)
			.padding(.horizontal, 12)
			.padding(.vertical, 6)
			.background(statusColor(property.status))
			.foregroundColor(.white)
			.clipShape(Capsule())
	}

	// MARK: - Financial Section

	private var financialSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Financial Summary")
				.font(.headline)

			if let estPrice = property.estPrice {
				LabeledValue(label: "Estimated Price", value: formatCurrency(estPrice))
			}

			if let estPriceLow = property.estPriceLow, let estPriceHigh = property.estPriceHigh {
				LabeledValue(label: "Price Range", value: "\(formatCurrency(estPriceLow)) - \(formatCurrency(estPriceHigh))")
			}

			if let purchasePrice = property.purchasePrice {
				LabeledValue(label: "Purchase Price", value: formatCurrency(purchasePrice))
			}

			if let lastPurchasePrice = property.lastPurchasePrice {
				LabeledValue(label: "Last Purchase Price", value: formatCurrency(Int(lastPurchasePrice)))
			}

			if let lastPurchaseDate = property.lastPurchaseDate {
				LabeledValue(label: "Last Purchase Date", value: formatDate(lastPurchaseDate))
			}

			if let annualTax = property.annualTaxAmount {
				LabeledValue(label: "Annual Tax", value: formatCurrency(annualTax))
			}

			if let rentEstimate = property.rentEstimate {
				LabeledValue(label: "Rent Estimate", value: formatCurrency(rentEstimate))
			}

			if let rentLow = property.rentEstimateLow, let rentHigh = property.rentEstimateHigh {
				LabeledValue(label: "Rent Range", value: "\(formatCurrency(rentLow)) - \(formatCurrency(rentHigh))")
			}
		}
	}

	// MARK: - Features Section

	private var featuresSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Property Features")
				.font(.headline)

			HStack(spacing: 20) {
				if let beds = property.beds {
					FeatureItem(icon: "bed.double.fill", value: "\(beds)", label: "Beds")
				}

				if let baths = property.baths {
					FeatureItem(icon: "shower.fill", value: String(format: "%.1f", baths), label: "Baths")
				}

				if let sqFt = property.squareFt {
					FeatureItem(icon: "square.fill", value: formatNumber(sqFt), label: "Sq Ft")
				}
			}

			if let builtIn = property.builtIn {
				LabeledValue(label: "Year Built", value: "\(builtIn)")
			}

			if let units = property.units {
				LabeledValue(label: "Units", value: "\(units)")
			}
		}
	}

	// MARK: - Scores Section

	private var scoresSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Location Scores")
				.font(.headline)

			if let walkScore = property.walkScore {
				ScoreRow(label: "Walk Score", score: walkScore)
			}

			if let transitScore = property.transitScore {
				ScoreRow(label: "Transit Score", score: transitScore)
			}

			if let bikeScore = property.bikeScore {
				ScoreRow(label: "Bike Score", score: bikeScore)
			}
		}
	}

	// MARK: - Risk Flags Section

	private var hasRiskFlags: Bool {
		property.inFloodZone == true ||
		property.hasOpenPulledPermits == true ||
		property.hasWorkDoneWoPermits == true ||
		property.hasDeedRestrictions == true ||
		property.hasHao == true ||
		property.hasHistoricPreservation == true ||
		property.hasEasements == true ||
		property.sellerCircumstances != nil
	}

	private var riskFlagsSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("Risk Flags")
				.font(.headline)
				.foregroundColor(.red)

			if property.inFloodZone == true {
				RiskFlag(text: "In Flood Zone")
			}

			if property.hasOpenPulledPermits == true {
				RiskFlag(text: "Has Open/Pulled Permits")
			}

			if property.hasWorkDoneWoPermits == true {
				RiskFlag(text: "Work Done Without Permits")
			}

			if property.hasDeedRestrictions == true {
				RiskFlag(text: "Has Deed Restrictions")
			}

			if property.hasHao == true {
				RiskFlag(text: "Has HOA")
			}

			if property.hasHistoricPreservation == true {
				RiskFlag(text: "Historic Preservation")
			}

			if property.hasEasements == true {
				RiskFlag(text: "Has Easements")
				if let easements = property.easements {
					Text(easements)
						.font(.caption)
						.foregroundColor(.secondary)
						.padding(.leading, 24)
				}
			}

			if let sellerCircumstances = property.sellerCircumstances {
				LabeledValue(label: "Seller Circumstances", value: sellerCircumstances.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)
			}
		}
	}

	// MARK: - Zillow Link Section

	@ViewBuilder
	private func zillowLinkSection(url: String) -> some View {
		if let validURL = URL(string: url) {
			Link(destination: validURL) {
				HStack {
					Image(systemName: "link")
					Text("View on Zillow")
					Spacer()
					Image(systemName: "arrow.up.right")
				}
				.padding()
				.background(Color.blue.opacity(0.1))
				.cornerRadius(10)
			}
		} else {
			HStack {
				Image(systemName: "link")
				Text("Invalid Zillow Link")
				Spacer()
			}
			.padding()
			.background(Color.gray.opacity(0.1))
			.foregroundColor(.secondary)
			.cornerRadius(10)
		}
	}

	// MARK: - Formatting Helpers

	private func formatCurrency(_ value: Int?) -> String {
		guard let value = value else { return "N/A" }
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.maximumFractionDigits = 0
		return formatter.string(from: NSNumber(value: value)) ?? "N/A"
	}

	private func formatDate(_ date: Date?) -> String {
		guard let date = date else { return "N/A" }
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter.string(from: date)
	}

	private func formatNumber(_ value: Int?) -> String {
		guard let value = value else { return "N/A" }
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter.string(from: NSNumber(value: value)) ?? "N/A"
	}

	private func statusColor(_ status: PropertyStatus) -> Color {
		switch status {
		case .active:
			return .green
		case .sold:
			return .gray
		case .passed:
			return .red
		case .pendingSale:
			return .yellow
		case .offMarket:
			return .orange
		}
	}
}

// MARK: - Supporting Views

struct LabeledValue: View {
	let label: String
	let value: String

	var body: some View {
		HStack {
			Text(label)
				.foregroundColor(.secondary)
			Spacer()
			Text(value)
				.fontWeight(.medium)
		}
	}
}

struct FeatureItem: View {
	let icon: String
	let value: String
	let label: String

	var body: some View {
		VStack(spacing: 4) {
			Image(systemName: icon)
				.font(.title3)
				.foregroundColor(.blue)
			Text(value)
				.font(.headline)
			Text(label)
				.font(.caption)
				.foregroundColor(.secondary)
		}
	}
}

struct ScoreRow: View {
	let label: String
	let score: Int

	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			HStack {
				Text(label)
					.foregroundColor(.secondary)
				Spacer()
				Text("\(score)")
					.fontWeight(.semibold)
			}

			ProgressView(value: Double(score), total: 100)
				.tint(scoreColor(score))
		}
	}

	private func scoreColor(_ score: Int) -> Color {
		switch score {
		case 0..<25:
			return .red
		case 25..<50:
			return .orange
		case 50..<75:
			return .yellow
		case 75...100:
			return .green
		default:
			return .gray
		}
	}
}

struct RiskFlag: View {
	let text: String

	var body: some View {
		HStack {
			Image(systemName: "exclamationmark.triangle.fill")
				.foregroundColor(.red)
			Text(text)
		}
	}
}

#Preview {
	NavigationStack {
		PropertyDetailView(property: Property(
			address1: "123 Main St",
			fullAddress: "123 Main St, Seattle, WA 98101",
			zillowLink: "https://www.zillow.com/example",
			county: "King County",
			purchasePrice: 500000,
			lastPurchasePrice: 480000,
			lastPurchaseDate: Date(),
			rentEstimate: 2500,
			rentEstimateLow: 2300,
			rentEstimateHigh: 2700,
			estPrice: 550000,
			estPriceLow: 525000,
			estPriceHigh: 575000,
			annualTaxAmount: 6000,
			annualElectricityCostEst: 1200,
			beds: 3,
			baths: 2.5,
			squareFt: 1800,
			builtIn: 2010,
			units: 1,
			walkScore: 85,
			transitScore: 70,
			bikeScore: 90,
			lat: 47.6062,
			lon: -122.3321,
			gasStationDistanceMiles: 0.5,
			schoolDistanceMiles: 0.3,
			universityDistanceMiles: 2.5,
			groceryOrSupermarketDistanceMiles: 0.8,
			hospitalDistanceMiles: 1.2,
			parkDistanceMiles: 0.4,
			transitStationDistanceMiles: 0.6,
			gasStationCount5mi: 12,
			schoolCount5mi: 8,
			universityCount5mi: 3,
			groceryOrSupermarketCount5mi: 15,
			hospitalCount5mi: 5,
			parkCount5mi: 10,
			transitStationCount5mi: 20,
			status: .active,
			listedDate: Date(),
			hasTenants: false,
			rentDdCompleted: true,
			hasReducedPrice: false,
			isFsbo: false,
			hasMarketResearch: true,
			sellerCircumstances: .relocation,
			hasOpenPulledPermits: false,
			hasWorkDoneWoPermits: false,
			hasDeedRestrictions: false,
			hasHao: true,
			hasHistoricPreservation: false,
			inFloodZone: false,
			hasEasements: false,
			easements: nil,
			setbacks: nil,
			obtainedCountyRecords: true,
			historicalTurnoverRate: 0.15,
			averageOwnershipDuration: 7.5,
			propertyConditionScore: 4,
			countyRecordNotes: "Property records up to date",
			permitNotes: nil,
			whitepagesNotes: nil
		))
	}
}
