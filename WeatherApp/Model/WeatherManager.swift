//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 28/06/2020.
//  Copyright © 2020 Rodrigo Cámara Robles. All rights reserved.
//

import Alamofire

class WeatherManager {
    
    //MARK: - Properties
    
    static var staticWeather = WeatherManager()
    //var delegate: WeatherDelegate?
    //let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?appid=2f46510f492a73f270b563fcc123ea51&units=metric"
    
    //MARK: - Public Methods
    
    func getWeatherForCityWithurl(endpoint: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(endpoint,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding(options:.prettyPrinted),
                   headers: nil).validate().responseJSON { DefaultDataResponse in
                    completion(DefaultDataResponse)
        }
        
    }
}
