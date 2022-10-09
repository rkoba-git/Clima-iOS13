//
//  WeatherData.swift
//  Clima
//
//  Created by 小林麟太郎 on 2022/05/18.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

//第１層
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

//第2層
struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
