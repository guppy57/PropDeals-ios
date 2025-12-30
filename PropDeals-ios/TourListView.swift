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
				ScrollView{
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
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
				}
				.navigationTitle(property.address1)
				.navigationBarTitleDisplayMode(.inline)
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

#Preview {
	TourListView()
}
