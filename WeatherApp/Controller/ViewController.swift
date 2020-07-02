//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 28/06/2020.
//  Copyright © 2020 Rodrigo Cámara Robles. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stackViewCity: UIStackView!
    @IBOutlet weak var stackViewWeather: UIStackView!
    
    // MARK: - Properties
    
    let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?appid=2f46510f492a73f270b563fcc123ea51&units=metric&q="
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stackViewCity.isHidden = true
        stackViewWeather.isHidden = true
    }
    
    // MARK: - Private Methods
    
    func getWeather(searchRequested: String) {
        
        let searchRequestedWithPercentEscapes = searchRequested.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        WeatherManager.staticWeather.getWeatherForCityWithurl(endpoint: weatherBaseURL+searchRequestedWithPercentEscapes!) { (AFDataResponse) in
            
            switch AFDataResponse.result {
            case .success(let value as [String: Any]):
                print ("Status Code: \(AFDataResponse.response!.statusCode)")
                print("SUCCESS: \(value)")
                
                if let jsonResult = try? JSONSerialization.jsonObject(with: AFDataResponse.data!, options: []) as? [String:AnyObject] {
                    let jsonData = try? JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                    
                    if let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData!) {
                        
                        let weatherObj =  WeatherModel(name: weatherData.name, temp: weatherData.main.temp, pressure: weatherData.main.pressure, humidity: weatherData.main.humidity, id: weatherData.weather[0].id, main: weatherData.weather[0].main, description: weatherData.weather[0].description, icon: weatherData.weather[0].icon, country: weatherData.sys.country)
                        
                        self.updateWeather(weather: weatherObj)
                    }
                }
            case .failure(let error):
                print("FAILURE: \(error)")
                self.handleErrorWithAlert(title: "Error", message: "No locations found. Try again", actionTitle: "OK")
            default:
                self.handleErrorWithAlert(title: "Error", message: "No locations found. Try again", actionTitle: "OK")
                fatalError("Received non-dictionary JSON response")
            }
        }
    }
    
    func updateWeather(weather: WeatherModel) {
        stackViewCity.isHidden = false
        stackViewWeather.isHidden = false
        self.cityNameLabel.text = weather.name
        self.countryLabel.text = weather.country
        self.tempLabel.text = String(format: "%.1f", weather.temp)
        self.weatherImage.image = UIImage(systemName: weather.weatherCondition)
    }
    
    func handleErrorWithAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: -UITextFieldDelegate
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        getWeather(searchRequested: textField.text!)
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

