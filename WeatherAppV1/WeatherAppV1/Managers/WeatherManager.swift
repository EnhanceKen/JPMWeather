//
//  WeatherManager.swift
//  WeatherAppV1
//
//  Created by Consultant on 5/19/23.
//

import Foundation
import CoreLocation

class WeatherManager {
    let apiKey = "83557a11325c1dde967920acbe28ed3c"
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=imperial&appid=\("83557a11325c1dde967920acbe28ed3c")") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching data")}
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
        
    }
    func getWeatherByCity(city: String) async throws -> ResponseBody {
            guard let safeCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                  let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(safeCity)&units=imperial&appid=\(apiKey)")
            else {
                throw URLError(.badURL)
            }
            
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
            return decodedData
        }
    
}
