//
//  PropertiesView.swift
//  PropDeals-ios
//
//  Created by Armaan Gupta on 12/26/25.
//

import SwiftUI
internal import PostgREST
import Supabase

struct PropertiesView: View {
	@State var properties: [Property] = []
	@State private var selectedProperty: Property? = nil

    var body: some View {
		List(properties) { property in
			Text(property.address1)
				.onTapGesture {
					selectedProperty = property
				}
		}
		.navigationTitle("All Properties")
		.sheet(item: $selectedProperty) { property in
			NavigationStack {
				PropertyDetailView(property: property)
					.navigationBarTitleDisplayMode(.inline)
					.toolbar {
						ToolbarItem(placement: .cancellationAction) {
							Button("Done") {
								selectedProperty = nil
							}
						}
					}
			}
		}
		.overlay {
			if properties.isEmpty {
				ProgressView()
			}
		}
		.task {
			do {
				properties = try await supabase.from("properties").select().execute().value
			} catch {
				dump(error)
			}
		}
    }
}

#Preview {
    PropertiesView()
}
