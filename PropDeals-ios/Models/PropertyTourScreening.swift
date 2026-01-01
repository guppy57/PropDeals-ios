//
//  PropertyTourScreening.swift
//  PropDeals-ios
//
//  Created by Armaan Gupta on 12/31/25.
//

import Foundation

struct PropertyTourScreening: Codable, Identifiable {

	// MARK: - Primary Identifiers & Dates

	let id: Int?
	let address1: String
	@SQLDate var tourDate: Date?
	let daysOnMarketAtTour: Int?

	// MARK: - Critical Red Flags

	let majorFoundationIssues: Bool?
	let activeRoofLeaks: Bool?
	let severeElectricalHazards: Bool?
	let severePlumbingIssues: Bool?
	let structuralConcerns: Bool?
	let majorWaterDamage: Bool?

	// MARK: - Major Systems Age/Condition

	let roofAgeYears: Int?
	let hvacAgeYears: Int?
	let hvacSystemType: String?
	let waterHeaterAgeYears: Int?
	let waterHeaterType: String?
	let waterHeaterCount: Int?
	let electricalPanelAgeYears: Int?
	let electricalServiceAmps: Int?
	let electricalPanelType: String?
	let windowsAgeYears: Int?
	let windowsType: String?
	let sidingAgeYears: Int?
	let sidingType: String?
	let foundationType: String?
	let plumbingMainLineType: String?

	// MARK: - Observational Scores

	let curbAppealScore: Int?
	let interiorConditionScore: Int?
	let layoutFunctionalityScore: Int?
	let streetConditionScore: Int?

	// MARK: - Rental Strategy

	let unitsCurrentlyRentable: Int?
	let unitsNeedMinorWork: Int?
	let unitsNeedMajorWork: Int?

	// MARK: - Value-Add Opportunities

	let hasUnfinishedBasement: Bool?
	let basementFinishPotential: Bool?
	let atticConversionPotential: Bool?
	let laundryUpgradeOpportunity: Bool?
	let parkingExpansionPossible: Bool?

	// MARK: - Competitive Intel

	let showingCondition: String?
	let sellerMotivationIndicators: String?
	let otherBuyersAtShowing: Bool?
	let biggestValueAddOpportunity: String?

	// MARK: - Neighborhood Observations

	let neighboringPropertiesCondition: String?
	let observedRedFlagsNearby: String?
	let observedAmenitiesNearby: String?

	// MARK: - Notes & Media

	let voiceNotes: String?
	let photoUrls: [String]?
	let voiceRecordingUrl: String?

	// MARK: - Inspection Decision

	let immediateSafetyRepairsNeeded: Bool?
	let immediateRepairsVoiceNotes: String?
	let worthDeeperInspection: Bool?

	// MARK: - Timestamps

	@SQLDate var createdAt: Date?
	@SQLDate var updatedAt: Date?

	// MARK: - CodingKeys

	enum CodingKeys: String, CodingKey {
		case id
		case address1
		case tourDate = "tour_date"
		case daysOnMarketAtTour = "days_on_market_at_tour"
		case majorFoundationIssues = "major_foundation_issues"
		case activeRoofLeaks = "active_roof_leaks"
		case severeElectricalHazards = "severe_electrical_hazards"
		case severePlumbingIssues = "severe_plumbing_issues"
		case structuralConcerns = "structural_concerns"
		case majorWaterDamage = "major_water_damage"
		case roofAgeYears = "roof_age_years"
		case hvacAgeYears = "hvac_age_years"
		case hvacSystemType = "hvac_system_type"
		case waterHeaterAgeYears = "water_heater_age_years"
		case waterHeaterType = "water_heater_type"
		case waterHeaterCount = "water_heater_count"
		case electricalPanelAgeYears = "electrical_panel_age_years"
		case electricalServiceAmps = "electrical_service_amps"
		case electricalPanelType = "electrical_panel_type"
		case windowsAgeYears = "windows_age_years"
		case windowsType = "windows_type"
		case sidingAgeYears = "siding_age_years"
		case sidingType = "siding_type"
		case foundationType = "foundation_type"
		case plumbingMainLineType = "plumbing_main_line_type"
		case curbAppealScore = "curb_appeal_score"
		case interiorConditionScore = "interior_condition_score"
		case layoutFunctionalityScore = "layout_functionality_score"
		case streetConditionScore = "street_condition_score"
		case unitsCurrentlyRentable = "units_currently_rentable"
		case unitsNeedMinorWork = "units_need_minor_work"
		case unitsNeedMajorWork = "units_need_major_work"
		case hasUnfinishedBasement = "has_unfinished_basement"
		case basementFinishPotential = "basement_finish_potential"
		case atticConversionPotential = "attic_conversion_potential"
		case laundryUpgradeOpportunity = "laundry_upgrade_opportunity"
		case parkingExpansionPossible = "parking_expansion_possible"
		case showingCondition = "showing_condition"
		case sellerMotivationIndicators = "seller_motivation_indicators"
		case otherBuyersAtShowing = "other_buyers_at_showing"
		case biggestValueAddOpportunity = "biggest_value_add_opportunity"
		case neighboringPropertiesCondition = "neighboring_properties_condition"
		case observedRedFlagsNearby = "observed_red_flags_nearby"
		case observedAmenitiesNearby = "observed_amenities_nearby"
		case voiceNotes = "voice_notes"
		case photoUrls = "photo_urls"
		case voiceRecordingUrl = "voice_recording_url"
		case immediateSafetyRepairsNeeded = "immediate_safety_repairs_needed"
		case immediateRepairsVoiceNotes = "immediate_repairs_voice_notes"
		case worthDeeperInspection = "worth_deeper_inspection"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}
