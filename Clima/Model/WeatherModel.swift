//
//  WeatherModel.swift
//  Clima
//
//  Created by 小林麟太郎 on 2022/05/21.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String{
        switch conditionId{
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.fog"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snowflake"
        case 700...781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    var cityNameString: String{
        return cityName
    }
}
