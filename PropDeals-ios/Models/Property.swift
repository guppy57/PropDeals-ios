import Foundation

// MARK: - PropertyStatus Enum

enum PropertyStatus: String, Codable {
    case active = "active"
    case sold = "sold"
    case passed = "passed"
    case pendingSale = "pending sale"
    case offMarket = "off market"
}

// MARK: - SellerCircumstance Enum

enum SellerCircumstance: String, Codable {
    case estateSale = "estate_sale"
    case financialDistress = "financial_distress"
    case divorce = "divorce"
    case relocation = "relocation"
    case inherited = "inherited"
    case downsizing = "downsizing"
    case upgrading = "upgrading"
    case portfolioLiquidation = "portfolio_liquidation"
}

// MARK: - SQLDate Property Wrapper

@propertyWrapper
struct SQLDate: Codable {
    var wrappedValue: Date?

    init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            wrappedValue = nil
            return
        }

        let dateString = try container.decode(String.self)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        wrappedValue = formatter.date(from: dateString)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        if let date = wrappedValue {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            try container.encode(formatter.string(from: date))
        } else {
            try container.encodeNil()
        }
    }
}

// MARK: - Property Model

struct Property: Codable, Identifiable {
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
    @SQLDate var lastPurchaseDate: Date?
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
    @SQLDate var listedDate: Date?

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
    }
}
