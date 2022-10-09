//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by 小林麟太郎 on 2022/05/25.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}
