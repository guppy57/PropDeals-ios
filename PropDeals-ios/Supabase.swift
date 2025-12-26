//
//  Supabase.swift
//  PropDeals-ios
//
//  Created by Armaan Gupta on 12/26/25.
//

import Foundation
import Supabase


let SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJwemRsZGNkc3dxd2Nsa29vc2dxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE4MzY3OTYsImV4cCI6MjA3NzQxMjc5Nn0.K5cisvseYOwW6PTXkNReMJmSQr0UzA5qwb1T7JrRcGE"
let SUPABASE_URL = "https://rpzdldcdswqwclkoosgq.supabase.co"

let supabase = SupabaseClient(
	supabaseURL: URL(string: SUPABASE_URL)!,
	supabaseKey: SUPABASE_KEY,
)
