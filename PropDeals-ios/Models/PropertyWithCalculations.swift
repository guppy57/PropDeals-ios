import Foundation

// MARK: - QualificationType Enum

enum QualificationType: String, Codable {
    case current = "current"
    case contingent = "contingent"
    case creative = "creative"
}

// MARK: - PropertyWithCalculations Model

struct PropertyWithCalculations: Codable, Identifiable {
    // MARK: - Primary Identifier
    let address1: String
    var id: String { address1 }

    // MARK: - Basic Information
    let fullAddress: String?
    let zillowLink: String?
    let county: String?

    // MARK: - Financial Information
    let purchasePrice: Int?
    let lastPurchasePrice: Double?
    var lastPurchaseDate: Date?
    let rentEstimate: Int?
    let rentEstimateLow: Int?
    let rentEstimateHigh: Int?
    let estPrice: Int?
    let estPriceLow: Int?
    let estPriceHigh: Int?
    let annualTaxAmount: Int?
    let annualElectricityCostEst: Int?

    // MARK: - Property Characteristics
    let beds: Int?
    let baths: Double?
    let squareFt: Int?
    let builtIn: Int?
    let units: Int?

    // MARK: - Walkability & Transit Scores
    let walkScore: Int?
    let transitScore: Int?
    let bikeScore: Int?

    // MARK: - Location Coordinates
    let lat: Double?
    let lon: Double?

    // MARK: - Nearby Facilities & Distances
    let gasStationDistanceMiles: Double?
    let schoolDistanceMiles: Double?
    let universityDistanceMiles: Double?
    let groceryOrSupermarketDistanceMiles: Double?
    let hospitalDistanceMiles: Double?
    let parkDistanceMiles: Double?
    let transitStationDistanceMiles: Double?

    // MARK: - Nearby Facilities Count (within 5 miles)
    let gasStationCount5mi: Int?
    let schoolCount5mi: Int?
    let universityCount5mi: Int?
    let groceryOrSupermarketCount5mi: Int?
    let hospitalCount5mi: Int?
    let parkCount5mi: Int?
    let transitStationCount5mi: Int?

    // MARK: - Property Status & Dates
    let status: PropertyStatus
    var listedDate: Date?

    // MARK: - Tenant & Rental Information
    let hasTenants: Bool?
    let rentDdCompleted: Bool?

    // MARK: - Price & Market Information
    let hasReducedPrice: Bool?
    let isFsbo: Bool?
    let hasMarketResearch: Bool?

    // MARK: - Seller Information
    let sellerCircumstances: SellerCircumstance?

    // MARK: - Legal & Restrictions
    let hasOpenPulledPermits: Bool?
    let hasWorkDoneWoPermits: Bool?
    let hasDeedRestrictions: Bool?
    let hasHao: Bool?
    let hasHistoricPreservation: Bool?
    let inFloodZone: Bool?
    let hasEasements: Bool?
    let easements: String?
    let setbacks: String?

    // MARK: - Records & Documentation
    let obtainedCountyRecords: Bool?
    let historicalTurnoverRate: Double?
    let averageOwnershipDuration: Double?
    let propertyConditionScore: Int?

    // MARK: - Notes & Documentation
    let countyRecordNotes: String?
    let permitNotes: String?
    let whitepagesNotes: String?

    // MARK: - Market & Neighborhood Analysis
    let marketTotalRentEstimate: Int?
    let minRent: Int?
    let minRentUnit: Int?
    let minRentUnitBeds: Int?
    let ownerUnitSqft: Double?
    let neighborhood: String?
    let neighborhoodLetterGrade: String?
    let nicheComLetterGrade: String?

    // MARK: - Property Metrics
    let costPerSqrft: Double?
    let homeAge: Double?
    let mobilityScore: Double?

    // MARK: - Loan & Down Payment
    let downPayment: Double?
    let fivePctLoan: Double?
    let loanAmount: Double?

    // MARK: - Monthly Costs
    let monthlyMortgage: Double?
    let monthlyMip: Double?
    let monthlyTaxes: Double?
    let monthlyInsurance: Double?

    // MARK: - Lender Costs
    let loanOriginationFee: Double?
    let creditReportingFee: Int?
    let appraisalFee: Int?
    let floodCertificationFee: Int?
    let taxServiceFee: Int?
    let processingFee: Int?
    let underwritingFee: Int?

    // MARK: - Title Costs
    let abstractUpdateFee: Int?
    let titleExaminationFee: Int?
    let titleGuarantyCertificate: Int?
    let ownersTitleInsurance: Int?
    let settlementFee: Int?
    let attorneyFee: Int?

    // MARK: - Government Costs
    let deedRecordingFee: Int?
    let mortgageRecordingFee: Int?
    let polkCountyTransferTax: Double?
    let polkCountyTransferFee: Int?

    // MARK: - Prepaid Costs
    let prepaidHomeInsurance: Double?
    let propertyTaxProration: Double?
    let prepaidInterest: Double?

    // MARK: - Escrow & Reserves
    let insuranceReserve: Double?
    let taxReserve: Double?

    // MARK: - Optional Costs
    let homeInspectionFee: Int?
    let propertySurveyFee: Int?
    let pestInspectionFee: Int?
    let courierFees: Int?
    let notaryFees: Int?

    // MARK: - Total Costs
    let totalLenderCosts: Double?
    let totalTitleCosts: Int?
    let totalGovernmentCosts: Double?
    let totalPrepaidCosts: Double?
    let totalEscrowCosts: Double?
    let totalOptionalCosts: Int?
    let closingCosts: Double?
    let closingCostsPrcnt: Double?
    let cashNeeded: Double?

    // MARK: - Rental Income Projections
    let quickMonthlyRentEstimate: Double?
    let ammoritizationEstimate: Double?
    let totalRent: Double?
    let annualRent: Double?

    // MARK: - Operating Expenses
    let monthlyVacancyCosts: Double?
    let monthlyRepairCosts: Double?
    let operatingExpenses: Double?

    // MARK: - Utilities
    let monthlyUtilityElectric: Double?
    let monthlyUtilityGas: Double?
    let monthlyUtilityWater: Double?
    let monthlyUtilityTrash: Double?
    let monthlyUtilityInternet: Double?
    let monthlyUtilityTotal: Double?
    let roommateUtilities: Double?
    let ownerUtilities: Double?

    // MARK: - Cash Flow Analysis
    let totalMonthlyCost: Double?
    let monthlyCashFlow: Double?
    let annualCashFlow: Double?

    // MARK: - Multi-Year Projections (Base Case)
    let y1OpexRentBase: Double?
    let y2RentBase: Double?
    let y2RentBaseSource: String?

    // MARK: - Multi-Year Projections (Market Rate)
    let mrMonthlyVacancyCosts: Double?
    let mrMonthlyRepairCosts: Double?
    let mrOperatingExpenses: Double?
    let mrTotalMonthlyCost: Double?
    let mrNetRentY1: Double?
    let mrNetRentY2: Double?
    let mrAnnualRentY1: Double?
    let mrAnnualRentY2: Double?
    let mrMonthlyNOIY1: Double?
    let mrMonthlyNOIY2: Double?
    let mrAnnualNOIY1: Double?
    let mrAnnualNOIY2: Double?
    let mrMonthlyCashFlowY1: Double?
    let mrMonthlyCashFlowY2: Double?
    let mrAnnualCashFlowY1: Double?
    let mrAnnualCashFlowY2: Double?
    let roommateUtilitiesY1: Double?
    let roommateUtilitiesY2: Double?
    let ownerUtilitiesY1: Double?
    let ownerUtilitiesY2: Double?

    // MARK: - Investment Metrics
    let capRateY1: Double?
    let capRateY2: Double?
    let coCY1: Double?
    let coCY2: Double?
    let grmY1: Double?
    let grmY2: Double?
    let mgrPP: Double?
    let opExRent: Double?
    let dscr: Double?
    let ltvRatio: Double?
    let pricePerDoor: Double?
    let rentPerSqft: Double?
    let breakEvenOccupancy: Double?
    let breakEvenVacancy: Double?
    let oer: Double?
    let egi: Double?
    let debtYield: Double?

    // MARK: - Long-term Forecasts
    let fiveYForecast: Double?
    let tenYForecast: Double?
    let twentyYForecast: Double?

    // MARK: - PITI & Tax Analysis
    let piti: Double?
    let costsToIncome: Double?
    let monthlyDepreciation: Double?
    let taxSavingsMonthly: Double?
    let afterTaxCashFlowY1: Double?
    let afterTaxCashFlowY2: Double?

    // MARK: - Future Value & Exit Analysis
    let futureValue5yr: Double?
    let futureValue10yr: Double?
    let futureValue20yr: Double?
    let netProceeds5yr: Double?
    let netProceeds10yr: Double?
    let netProceeds20yr: Double?

    // MARK: - Return Metrics
    let equityMultiple5yr: Double?
    let equityMultiple10yr: Double?
    let equityMultiple20yr: Double?
    let avgAnnualReturn5yr: Double?
    let avgAnnualReturn10yr: Double?
    let avgAnnualReturn20yr: Double?
    let roeY2: Double?
    let leverageBenefit: Double?
    let paybackPeriodYears: Double?
    let irr5yr: Double?
    let irr10yr: Double?
    let irr20yr: Double?
    let npv5yr: Double?
    let npv10yr: Double?
    let npv20yr: Double?

    // MARK: - Valuation Metrics
    let fairValue5yr: Double?
    let fairValue10yr: Double?
    let fairValue20yr: Double?
    let valueGapPct5yr: Double?
    let valueGapPct10yr: Double?
    let valueGapPct20yr: Double?

    // MARK: - Deal Quality Indicators
    let beatsMarket: Bool?
    let cashFlowY1Downside10pct: Double?
    let cashFlowY2Downside10pct: Double?
    let fhaSelfSufficiencyRatio: Double?

    // MARK: - HomeStyle Renovation Analysis
    let hsRenovationCost: Int?
    let hsArv: Double?
    let hsTotalProjectCost: Int?
    let hsLtvLimit: Double?
    let hsMaxLoanArvBasis: Double?
    let hsMaxLoanCostBasis: Double?
    let hsMaxLoanAmount: Double?
    let hsMaxRenovationFinancing: Double?
    let hsDownPayment: Double?
    let hsOutOfPocketRenovation: Double?
    let hsCashNeeded: Double?
    let hsBorrowingGap: Double?
    let hsLtvRatio: Double?
    let hsBuiltInEquity: Double?
    let hsEquityPct: Double?
    let hsCostPerSqft: Double?
    let hsArvPerSqft: Double?
    let hsRenovationValueAdd: Double?
    let hsRenovationRoi: Double?
    let hsAllInBasis: Double?
    let hsIsFeasible: Bool?
    let hsDealScore: Double?

    // MARK: - Additional Fields
    let qualificationType: QualificationType?
    let originalPrice: Int?
    let additionalRoomRent: Double?
    let mrCapRateY1: Double?
    let mrCoCY1: Double?
    let mrGrmY1: Double?

    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case address1
        case fullAddress = "full_address"
        case zillowLink = "zillow_link"
        case county
        case purchasePrice = "purchase_price"
        case lastPurchasePrice = "last_purchase_price"
        case lastPurchaseDate = "last_purchase_date"
        case rentEstimate = "rent_estimate"
        case rentEstimateLow = "rent_estimate_low"
        case rentEstimateHigh = "rent_estimate_high"
        case estPrice = "est_price"
        case estPriceLow = "est_price_low"
        case estPriceHigh = "est_price_high"
        case annualTaxAmount = "annual_tax_amount"
        case annualElectricityCostEst = "annual_electricity_cost_est"
        case beds
        case baths
        case squareFt = "square_ft"
        case builtIn = "built_in"
        case units
        case walkScore = "walk_score"
        case transitScore = "transit_score"
        case bikeScore = "bike_score"
        case lat
        case lon
        case gasStationDistanceMiles = "gas_station_distance_miles"
        case schoolDistanceMiles = "school_distance_miles"
        case universityDistanceMiles = "university_distance_miles"
        case groceryOrSupermarketDistanceMiles = "grocery_or_supermarket_distance_miles"
        case hospitalDistanceMiles = "hospital_distance_miles"
        case parkDistanceMiles = "park_distance_miles"
        case transitStationDistanceMiles = "transit_station_distance_miles"
        case gasStationCount5mi = "gas_station_count_5mi"
        case schoolCount5mi = "school_count_5mi"
        case universityCount5mi = "university_count_5mi"
        case groceryOrSupermarketCount5mi = "grocery_or_supermarket_count_5mi"
        case hospitalCount5mi = "hospital_count_5mi"
        case parkCount5mi = "park_count_5mi"
        case transitStationCount5mi = "transit_station_count_5mi"
        case status
        case listedDate = "listed_date"
        case hasTenants = "has_tenants"
        case rentDdCompleted = "rent_dd_completed"
        case hasReducedPrice = "has_reduced_price"
        case isFsbo = "is_fsbo"
        case hasMarketResearch = "has_market_research"
        case sellerCircumstances = "seller_circumstances"
        case hasOpenPulledPermits = "has_open_pulled_permits"
        case hasWorkDoneWoPermits = "has_work_done_wo_permits"
        case hasDeedRestrictions = "has_deed_restrictions"
        case hasHao = "has_hao"
        case hasHistoricPreservation = "has_historic_preservation"
        case inFloodZone = "in_flood_zone"
        case hasEasements = "has_easements"
        case easements
        case setbacks
        case obtainedCountyRecords = "obtained_county_records"
        case historicalTurnoverRate = "historical_turnover_rate"
        case averageOwnershipDuration = "average_ownership_duration"
        case propertyConditionScore = "property_condition_score"
        case countyRecordNotes = "county_record_notes"
        case permitNotes = "permit_notes"
        case whitepagesNotes = "whitepages_notes"
        case marketTotalRentEstimate = "market_total_rent_estimate"
        case minRent = "min_rent"
        case minRentUnit = "min_rent_unit"
        case minRentUnitBeds = "min_rent_unit_beds"
        case ownerUnitSqft = "owner_unit_sqft"
        case neighborhood
        case neighborhoodLetterGrade = "neighborhood_letter_grade"
        case nicheComLetterGrade = "niche_com_letter_grade"
        case costPerSqrft = "cost_per_sqrft"
        case homeAge = "home_age"
        case mobilityScore = "mobility_score"
        case downPayment = "down_payment"
        case fivePctLoan = "5_pct_loan"
        case loanAmount = "loan_amount"
        case monthlyMortgage = "monthly_mortgage"
        case monthlyMip = "monthly_mip"
        case monthlyTaxes = "monthly_taxes"
        case monthlyInsurance = "monthly_insurance"
        case loanOriginationFee = "loan_origination_fee"
        case creditReportingFee = "credit_reporting_fee"
        case appraisalFee = "appraisal_fee"
        case floodCertificationFee = "flood_certification_fee"
        case taxServiceFee = "tax_service_fee"
        case processingFee = "processing_fee"
        case underwritingFee = "underwriting_fee"
        case abstractUpdateFee = "abstract_update_fee"
        case titleExaminationFee = "title_examination_fee"
        case titleGuarantyCertificate = "title_guaranty_certificate"
        case ownersTitleInsurance = "owners_title_insurance"
        case settlementFee = "settlement_fee"
        case attorneyFee = "attorney_fee"
        case deedRecordingFee = "deed_recording_fee"
        case mortgageRecordingFee = "mortgage_recording_fee"
        case polkCountyTransferTax = "polk_county_transfer_tax"
        case polkCountyTransferFee = "polk_county_transfer_fee"
        case prepaidHomeInsurance = "prepaid_home_insurance"
        case propertyTaxProration = "property_tax_proration"
        case prepaidInterest = "prepaid_interest"
        case insuranceReserve = "insurance_reserve"
        case taxReserve = "tax_reserve"
        case homeInspectionFee = "home_inspection_fee"
        case propertySurveyFee = "property_survey_fee"
        case pestInspectionFee = "pest_inspection_fee"
        case courierFees = "courier_fees"
        case notaryFees = "notary_fees"
        case totalLenderCosts = "total_lender_costs"
        case totalTitleCosts = "total_title_costs"
        case totalGovernmentCosts = "total_government_costs"
        case totalPrepaidCosts = "total_prepaid_costs"
        case totalEscrowCosts = "total_escrow_costs"
        case totalOptionalCosts = "total_optional_costs"
        case closingCosts = "closing_costs"
        case closingCostsPrcnt = "closing_costs_prcnt"
        case cashNeeded = "cash_needed"
        case quickMonthlyRentEstimate = "quick_monthly_rent_estimate"
        case ammoritizationEstimate = "ammoritization_estimate"
        case totalRent = "total_rent"
        case annualRent = "annual_rent"
        case monthlyVacancyCosts = "monthly_vacancy_costs"
        case monthlyRepairCosts = "monthly_repair_costs"
        case operatingExpenses = "operating_expenses"
        case monthlyUtilityElectric = "monthly_utility_electric"
        case monthlyUtilityGas = "monthly_utility_gas"
        case monthlyUtilityWater = "monthly_utility_water"
        case monthlyUtilityTrash = "monthly_utility_trash"
        case monthlyUtilityInternet = "monthly_utility_internet"
        case monthlyUtilityTotal = "monthly_utility_total"
        case roommateUtilities = "roommate_utilities"
        case ownerUtilities = "owner_utilities"
        case totalMonthlyCost = "total_monthly_cost"
        case monthlyCashFlow = "monthly_cash_flow"
        case annualCashFlow = "annual_cash_flow"
        case y1OpexRentBase = "y1_opex_rent_base"
        case y2RentBase = "y2_rent_base"
        case y2RentBaseSource = "y2_rent_base_source"
        case mrMonthlyVacancyCosts = "mr_monthly_vacancy_costs"
        case mrMonthlyRepairCosts = "mr_monthly_repair_costs"
        case mrOperatingExpenses = "mr_operating_expenses"
        case mrTotalMonthlyCost = "mr_total_monthly_cost"
        case mrNetRentY1 = "mr_net_rent_y1"
        case mrNetRentY2 = "mr_net_rent_y2"
        case mrAnnualRentY1 = "mr_annual_rent_y1"
        case mrAnnualRentY2 = "mr_annual_rent_y2"
        case mrMonthlyNOIY1 = "mr_monthly_NOI_y1"
        case mrMonthlyNOIY2 = "mr_monthly_NOI_y2"
        case mrAnnualNOIY1 = "mr_annual_NOI_y1"
        case mrAnnualNOIY2 = "mr_annual_NOI_y2"
        case mrMonthlyCashFlowY1 = "mr_monthly_cash_flow_y1"
        case mrMonthlyCashFlowY2 = "mr_monthly_cash_flow_y2"
        case mrAnnualCashFlowY1 = "mr_annual_cash_flow_y1"
        case mrAnnualCashFlowY2 = "mr_annual_cash_flow_y2"
        case roommateUtilitiesY1 = "roommate_utilities_y1"
        case roommateUtilitiesY2 = "roommate_utilities_y2"
        case ownerUtilitiesY1 = "owner_utilities_y1"
        case ownerUtilitiesY2 = "owner_utilities_y2"
        case capRateY1 = "cap_rate_y1"
        case capRateY2 = "cap_rate_y2"
        case coCY1 = "CoC_y1"
        case coCY2 = "CoC_y2"
        case grmY1 = "GRM_y1"
        case grmY2 = "GRM_y2"
        case mgrPP = "MGR_PP"
        case opExRent = "OpEx_Rent"
        case dscr = "DSCR"
        case ltvRatio = "ltv_ratio"
        case pricePerDoor = "price_per_door"
        case rentPerSqft = "rent_per_sqft"
        case breakEvenOccupancy = "break_even_occupancy"
        case breakEvenVacancy = "break_even_vacancy"
        case oer
        case egi
        case debtYield = "debt_yield"
        case fiveYForecast = "5y_forecast"
        case tenYForecast = "10y_forecast"
        case twentyYForecast = "20y_forecast"
        case piti
        case costsToIncome = "costs_to_income"
        case monthlyDepreciation = "monthly_depreciation"
        case taxSavingsMonthly = "tax_savings_monthly"
        case afterTaxCashFlowY1 = "after_tax_cash_flow_y1"
        case afterTaxCashFlowY2 = "after_tax_cash_flow_y2"
        case futureValue5yr = "future_value_5yr"
        case futureValue10yr = "future_value_10yr"
        case futureValue20yr = "future_value_20yr"
        case netProceeds5yr = "net_proceeds_5yr"
        case netProceeds10yr = "net_proceeds_10yr"
        case netProceeds20yr = "net_proceeds_20yr"
        case equityMultiple5yr = "equity_multiple_5yr"
        case equityMultiple10yr = "equity_multiple_10yr"
        case equityMultiple20yr = "equity_multiple_20yr"
        case avgAnnualReturn5yr = "avg_annual_return_5yr"
        case avgAnnualReturn10yr = "avg_annual_return_10yr"
        case avgAnnualReturn20yr = "avg_annual_return_20yr"
        case roeY2 = "roe_y2"
        case leverageBenefit = "leverage_benefit"
        case paybackPeriodYears = "payback_period_years"
        case irr5yr = "irr_5yr"
        case irr10yr = "irr_10yr"
        case irr20yr = "irr_20yr"
        case npv5yr = "npv_5yr"
        case npv10yr = "npv_10yr"
        case npv20yr = "npv_20yr"
        case fairValue5yr = "fair_value_5yr"
        case fairValue10yr = "fair_value_10yr"
        case fairValue20yr = "fair_value_20yr"
        case valueGapPct5yr = "value_gap_pct_5yr"
        case valueGapPct10yr = "value_gap_pct_10yr"
        case valueGapPct20yr = "value_gap_pct_20yr"
        case beatsMarket = "beats_market"
        case cashFlowY1Downside10pct = "cash_flow_y1_downside_10pct"
        case cashFlowY2Downside10pct = "cash_flow_y2_downside_10pct"
        case fhaSelfSufficiencyRatio = "fha_self_sufficiency_ratio"
        case hsRenovationCost = "hs_renovation_cost"
        case hsArv = "hs_arv"
        case hsTotalProjectCost = "hs_total_project_cost"
        case hsLtvLimit = "hs_ltv_limit"
        case hsMaxLoanArvBasis = "hs_max_loan_arv_basis"
        case hsMaxLoanCostBasis = "hs_max_loan_cost_basis"
        case hsMaxLoanAmount = "hs_max_loan_amount"
        case hsMaxRenovationFinancing = "hs_max_renovation_financing"
        case hsDownPayment = "hs_down_payment"
        case hsOutOfPocketRenovation = "hs_out_of_pocket_renovation"
        case hsCashNeeded = "hs_cash_needed"
        case hsBorrowingGap = "hs_borrowing_gap"
        case hsLtvRatio = "hs_ltv_ratio"
        case hsBuiltInEquity = "hs_built_in_equity"
        case hsEquityPct = "hs_equity_pct"
        case hsCostPerSqft = "hs_cost_per_sqft"
        case hsArvPerSqft = "hs_arv_per_sqft"
        case hsRenovationValueAdd = "hs_renovation_value_add"
        case hsRenovationRoi = "hs_renovation_roi"
        case hsAllInBasis = "hs_all_in_basis"
        case hsIsFeasible = "hs_is_feasible"
        case hsDealScore = "hs_deal_score"
        case qualificationType = "qualification_type"
        case originalPrice = "original_price"
        case additionalRoomRent = "additional_room_rent"
        case mrCapRateY1 = "mr_cap_rate_y1"
        case mrCoCY1 = "mr_CoC_y1"
        case mrGrmY1 = "mr_GRM_y1"
    }
}
