//
//  GeocodeResponse.swift
//  DemoWeatherApp
//
//  Created by Maria Francis on 8/20/24.
//

import Foundation

struct Location: Codable {
    let zip: String
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}

