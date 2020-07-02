//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 28/06/2020.
//  Copyright © 2020 Rodrigo Cámara Robles. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
    
    enum CodingKeys: String, CodingKey {
        case name
        case main = "main"
        case weather = "weather"
        case sys = "sys"
    }
    
    struct Main: Codable {
        let temp: Double
        let pressure: Double
        let humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case temp = "temp"
            case pressure = "pressure"
            case humidity = "humidity"
        }
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case main = "main"
            case description = "description"
            case icon = "icon"
        }
    }
    
    struct Sys: Codable {
        let country: String
        
        enum CodingKeys: String, CodingKey {
            case country = "country"
        }
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        sys = try values.decode(Sys.self, forKey: .sys)
        main = try values.decode(Main.self, forKey: .main)
        weather = try values.decode([Weather].self, forKey: .weather)
    }
}



