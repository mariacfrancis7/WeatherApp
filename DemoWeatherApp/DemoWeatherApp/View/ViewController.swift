//
//  ViewController.swift
//  DemoWeatherApp
//
//  Created by Maria Francis on 8/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var RainLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    let weatherService = WeatherService()
    private let userDefaults = UserDefaults.standard
    private let lastCityKey = "lastCity"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        displayLastSearchedCity()
    }
    
    @IBAction func onSearch(_ sender: Any) {
        if let city = textField.text, !city.isEmpty {
            saveLastSearchedCity(city)
            getWeatherData(cityName: city)
        } else {
            self.showAlert(withTitle: "Attention", message: "Please enter a valid city name!")
        }
    }
    
    func getWeatherData(cityName: String) {
        weatherService.fetchWeather(for: cityName) { result in
            switch result {
            case .success(let weatherResponse):
                let sunriseTimestamp = TimeInterval(weatherResponse.sys.sunrise)
                let sunriseUTC = self.convertSunriseToUTC(timestamp: sunriseTimestamp)
                let sunsetTimestamp = TimeInterval(weatherResponse.sys.sunset)
                let sunsetUTC = self.convertSunriseToUTC(timestamp: sunsetTimestamp)
                DispatchQueue.main.async() {
                    self.cityNameLabel.text = weatherResponse.name
                    self.temperatureLabel.text = String("Temp: \(weatherResponse.main.temp)")
                    if let icon = self.weatherService.iconImage {
                        self.iconImage.image = icon
                    }
                    if let rainData = weatherResponse.rain?.oneHour {
                        self.RainLabel.text = String(rainData)
                    }
                    self.minTempLabel.text = String("Min Temp: \(weatherResponse.main.tempMin) C")
                    self.maxTempLabel.text = String("Max temp: \(weatherResponse.main.tempMax) C")
                    self.pressureLabel.text = String("Pressure: \(weatherResponse.main.pressure) hPa")
                    self.humidityLabel.text = String("Humidity: \(weatherResponse.main.humidity) %")
                    self.sunriseLabel.text = String("Sunrise: \(sunriseUTC)")
                    self.sunsetLabel.text = String("Sunset: \(sunsetUTC)")
                    self.windSpeedLabel.text = String("Wind Speed: \(weatherResponse.wind.speed) meter/sec")
                }
            case .failure(let error):
                print("Error fetching weather: \(error)")
                self.showAlert(withTitle: "Attention", message: "Something went wrong!")
            }
        }
    }
    
    func showAlert(withTitle title: String, message: String) {
          
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
        
            present(alert, animated: true, completion: nil)
        }
    
    func saveLastSearchedCity(_ city: String) {
            userDefaults.set(city, forKey: lastCityKey)
            userDefaults.synchronize()
        }
    
    func getLastSearchedCity() -> String? {
            return userDefaults.string(forKey: lastCityKey)
        }
    
    func displayLastSearchedCity() {
            if let lastCity = getLastSearchedCity() {
                DispatchQueue.main.async {
                    //self.cityNameLabel.text = "Last searched city: \(lastCity)"
                    self.getWeatherData(cityName: lastCity)
                }
            }
        }
    
    func convertSunriseToUTC(timestamp: TimeInterval) -> String {
        let sunriseDate = Date(timeIntervalSince1970: timestamp)
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyy HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
        return dateFormatter.string(from: sunriseDate)
    }

}

