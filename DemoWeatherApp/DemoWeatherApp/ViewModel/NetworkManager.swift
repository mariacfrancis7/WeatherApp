//
//  NetworkManager.swift
//  DemoWeatherApp
//
//  Created by Maria Francis on 8/20/24.
//

import Foundation
import UIKit

class WeatherService {
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "8a2295471bff486a4e68ddb9876e9fb4"
    let iconSize = "@2x.png"
    var iconImage: UIImage?
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                if let icon = weatherResponse.weather.first?.icon {
                    let imageURL = "\(baseURL)\(icon)\(iconSize)"
                    downloadImage(from: imageURL)
                }
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String) {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Failed to download image: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to convert data to image")
                    return
                }
                self?.iconImage = image
        
            }.resume()
        }
}
   
