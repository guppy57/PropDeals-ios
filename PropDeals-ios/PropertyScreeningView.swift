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

	// Local state for form fields (for immediate UI updates)
	@State private var voiceNotes: String = ""
	@State private var immediateRepairsNotes: String = ""
	@State private var curbAppealScore: String = ""

	// Debounce task for auto-save
	@State private var saveTask: Task<Void, Never>?
	@State private var isSaving = false

    var body: some View {
		ScrollView {
//			if isLoading {
//				ProgressView()
//					.frame(maxWidth: .infinity, maxHeight: .infinity)
//			} else if screeningData != nil {
//				VStack(alignment: .leading, spacing: 20) {
//					// Example: Multi-line text field
//					VStack(alignment: .leading, spacing: 8) {
//						HStack {
//							Text("Voice Notes")
//								.font(.headline)
//							Spacer()
//							if isSaving {
//								ProgressView()
//									.scaleEffect(0.8)
//							}
//						}
//
//						TextEditor(text: $voiceNotes)
//							.frame(minHeight: 100)
//							.padding(8)
//							.background(Color(.systemGray6))
//							.cornerRadius(8)
//							.onChange(of: voiceNotes) { oldValue, newValue in
//								autoSave(field: "voice_notes", value: newValue)
//							}
//					}
//
//					// Example: Another multi-line text field
//					VStack(alignment: .leading, spacing: 8) {
//						Text("Immediate Repairs Notes")
//							.font(.headline)
//
//						TextEditor(text: $immediateRepairsNotes)
//							.frame(minHeight: 100)
//							.padding(8)
//							.background(Color(.systemGray6))
//							.cornerRadius(8)
//							.onChange(of: immediateRepairsNotes) { oldValue, newValue in
//								autoSave(field: "immediate_repairs_voice_notes", value: newValue)
//							}
//					}
//
//					// Example: Number field with TextField
//					VStack(alignment: .leading, spacing: 8) {
//						Text("Curb Appeal Score (1-10)")
//							.font(.headline)
//
//						TextField("Score", text: $curbAppealScore)
//							.keyboardType(.numberPad)
//							.padding(12)
//							.background(Color(.systemGray6))
//							.cornerRadius(8)
//							.onChange(of: curbAppealScore) { oldValue, newValue in
//								// Convert to Int and save
//								if let score = Int(newValue), score >= 1 && score <= 10 {
//									autoSave(field: "curb_appeal_score", value: score)
//								} else if newValue.isEmpty {
//									autoSave(field: "curb_appeal_score", value: nil)
//								}
//							}
//					}
//				}
//				.padding()
//			} else {
//				VStack(spacing: 16) {
//					Text("No screening data found")
//					Button("Create New Screening") {
//						Task {
//							await createNewScreening()
//						}
//					}
//					.buttonStyle(.borderedProminent)
//				}
//			}
		}
		.navigationTitle("Property screening")
		.task {
			print("nothing")
//			await loadScreeningData()
		}
    }

//	private func loadScreeningData() async {
//		isLoading = true
//		defer { isLoading = false }
//
//		do {
//			// Check if this property has screening data
//			let screenings: [PropertyTourScreening] = try await supabase
//				.from("property_tour_screening")
//				.select("*")
//				.eq("address1", value: property.address1)
//				.execute()
//				.value
//
//			if screenings.isEmpty {
//				print("No screening found for \(property.address1)")
//			} else {
//				// Use the first (most recent) screening record
//				screeningData = screenings.first
//				print("Loaded screening data for \(property.address1)")
//
//				// Populate form fields from loaded data
//				populateFormFields()
//			}
//
//		} catch {
//			print("Error loading screening data: \(error)")
//		}
//	}
//
//	// MARK: - Form Field Management
//
//	/// Populate local form fields from screeningData
//	private func populateFormFields() {
//		guard let data = screeningData else { return }
//
//		voiceNotes = data.voiceNotes ?? ""
//		immediateRepairsNotes = data.immediateRepairsVoiceNotes ?? ""
//		curbAppealScore = data.curbAppealScore.map { String($0) } ?? ""
//	}
//
//	// MARK: - Auto-Save
//
//	/// Auto-save with debouncing (waits 1 second after user stops typing)
//	private func autoSave<T: Encodable>(field: String, value: T?) {
//		// Cancel previous save task
//		saveTask?.cancel()
//
//		// Create new debounced save task
//		saveTask = Task {
//			// Wait for 1 second of inactivity
//			try? await Task.sleep(nanoseconds: 1_000_000_000)
//
//			// Check if task was cancelled
//			guard !Task.isCancelled else { return }
//
//			// Perform the save
//			await performSave(field: field, value: value)
//		}
//	}
//
//	/// Perform the actual save operation
//	private func performSave<T: Encodable>(field: String, value: T?) async {
//		guard let screeningId = screeningData?.id else {
//			print("No screening ID available for save")
//			return
//		}
//
//		isSaving = true
//		defer { isSaving = false }
//
//		do {
//			// Update the specific field in Supabase
//			try await supabase
//				.from("property_tour_screening")
//				.update([field: value as Any])
//				.eq("id", value: screeningId)
//				.execute()
//
//			// Refresh the local screeningData to stay in sync
//			await refreshScreeningData()
//
//			print("✓ Saved \(field)")
//
//		} catch {
//			print("Error saving \(field): \(error)")
//		}
//	}

	/// Refresh screeningData from database after save
//	private func refreshScreeningData() async {
//		guard let screeningId = screeningData?.id else { return }
//
//		do {
//			let updated: [PropertyTourScreening] = try await supabase
//				.from("property_tour_screening")
//				.select("*")
//				.eq("id", value: screeningId)
//				.execute()
//				.value
//
//			if let updatedData = updated.first {
//				screeningData = updatedData
//			}
//		} catch {
//			print("Error refreshing screening data: \(error)")
//		}
//	}

	// MARK: - Create New Screening

	/// Create a new screening record for this property
//	private func createNewScreening() async {
//		isLoading = true
//		defer { isLoading = false }
//
//		do {
//			// Create new screening with minimal required fields
//			let newScreening: [String: Any] = [
//				"address1": property.address1,
//				"tour_date": ISO8601DateFormatter().string(from: Date())
//			]
//
//			let created: [PropertyTourScreening] = try await supabase
//				.from("property_tour_screening")
//				.insert(newScreening)
//				.select()
//				.execute()
//				.value
//
//			if let newData = created.first {
//				screeningData = newData
//				populateFormFields()
//				print("Created new screening for \(property.address1)")
//			}
//
//		} catch {
//			print("Error creating screening: \(error)")
//		}
//	}
}

// #Preview {
//     PropertyScreeningView(property: PropertyWithCalculations())
// }
