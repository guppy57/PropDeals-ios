//
//  ContentView.swift
//  PropDeals-ios
//
//  Created by Armaan Gupta on 12/26/25.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedTab: Tab = .properties
	@State private var showingAddProperty = false

	var body: some View {
		TabView(selection: $selectedTab) {
			NavigationStack {
				PropertiesView()
			}
			.tabItem {
				Label("Properties", systemImage: "house.fill")
			}
			.tag(Tab.properties)

			NavigationStack {
				TourListView()
			}
			.tabItem {
				Label("Tour List", systemImage: "magnifyingglass")
			}
			.tag(Tab.tourList)
		}
	}
}

enum Tab: Hashable {
	case properties, tourList
}

#Preview {
	ContentView()
}

