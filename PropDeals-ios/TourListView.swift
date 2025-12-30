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
				VStack(alignment: .leading, spacing: 20) {
					Text("Todo")
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

				// Print the actual JSON response
				if let jsonString = String(data: data, encoding: .utf8) {
					print("=== API Response ===")
					print(jsonString)
					print("===================")
				}

				// Try to decode as generic JSON to inspect structure
				if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
					print("=== Response Structure ===")
					if let properties = json["properties"] as? [[String: Any]] {
						print("Number of properties: \(properties.count)")
						if let firstProperty = properties.first {
							print("First property keys: \(firstProperty.keys.sorted())")
							print("Has last_purchase_date? \(firstProperty["last_purchase_date"] != nil)")
						}
					}
					print("=========================")
				}

				// SQL date formatter for "yyyy-MM-dd" format
				let sqlDateFormatter: DateFormatter = {
					let formatter = DateFormatter()
					formatter.dateFormat = "yyyy-MM-dd"
					formatter.locale = Locale(identifier: "en_US_POSIX")
					formatter.timeZone = TimeZone(secondsFromGMT: 0)
					return formatter
				}()

				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
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
