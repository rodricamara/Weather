//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 28/06/2020.
//  Copyright © 2020 Rodrigo Cámara Robles. All rights reserved.
//

import Foundation

struct WeatherModel {
    let name: String
    //Main
    let temp: Double
    let pressure: Double
    let humidity: Double
    //Weather
    let id: Int
    let main: String
    let description:String
    let icon: String
    //Sys
    let country:String
    
    //Weather Conditions: - https://openweathermap.org/weather-conditions
    //Computed property
    var weatherCondition: String {
        switch icon {
        case "11d":
            return "cloud.bolt"
        case "09d":
            return "cloud.drizzle"
        case "10d":
            return "cloud.sun.rain"
        case "13d":
            return "cloud.snow"
        case "50d":
            return "cloud.fog"
        case "01d":
            return "sun.max"
        case "01n":
            return "moon.stars"
        case "02d":
            return "cloud.sun"
        case "02n":
            return "cloud.moon"
        case "03d":
            return "cloud"
        case "03n":
            return "cloud"
        case "04d":
            return "cloud"
        case "04n":
            return "cloud.moon"
        default:
            return "globe"
        }
    }
    
}
