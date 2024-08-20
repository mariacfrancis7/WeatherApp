//
//  Sys.swift
//  DemoWeatherApp
//
//  Created by Maria Francis on 8/20/24.
//

import Foundation

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int
    let sunset: Int
}
