//
//  PropertyScreeningView.swift
//  PropDeals-ios
//
//  Created by Armaan Gupta on 12/31/25.
//

import SwiftUI
internal import PostgREST
import Supabase

struct PropertyScreeningView: View {
	let property: PropertyWithCalculations
	@State private var isLoading = false
	@State private var screeningData: PropertyTourScreening? = nil

    var body: some View {
		ScrollView {
			if isLoading {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
				// Your actual content here
				Text("Hello, World!")
			}
		}
		.navigationTitle("Property screening")
		.task {
			await loadScreeningData()
		}
    }

	private func loadScreeningData() async {
		isLoading = true
		defer { isLoading = false }

		do {
			// Check if this property has screening data
			let screenings: [PropertyTourScreening] = try await supabase
				.from("property_tour_screening")
				.select("*")
				.eq("address1", value: property.address1)
				.execute()
				.value

			if screenings.isEmpty {
				print("No screening found for \(property.address1)")
				// TODO: Create new screening record if needed
			} else {
				// Use the first (most recent) screening record
				screeningData = screenings.first
				print("Loaded screening data for \(property.address1)")
			}

		} catch {
			print("Error loading screening data: \(error)")
		}
	}
}

// #Preview {
//     PropertyScreeningView(property: PropertyWithCalculations())
// }
