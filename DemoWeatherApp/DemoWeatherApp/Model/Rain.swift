//
//  Rain.swift
//  DemoWeatherApp
//
//  Created by Maria Francis on 8/20/24.
//

import Foundation

struct Rain: Codable {
    let oneHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
