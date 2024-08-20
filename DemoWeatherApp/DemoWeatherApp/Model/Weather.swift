//
//  Weather.swift
//  DemoWeatherApp
//
//  Created by Maria Francis on 8/20/24.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
