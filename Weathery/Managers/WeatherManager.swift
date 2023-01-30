//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Tiago Valente on 27/01/2023.
//

import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather(latitude:CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody{
        guard let url = URL(string:"https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&temperature_unit=celsius&hourly=apparent_temperature&hourly=relativehumidity_2m&daily=temperature_2m_max&daily=temperature_2m_min&timezone=GMT") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let(data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error fetching weather data")}

        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var latitude: Double
    var longitude: Double
    var generationtime_ms : Double
    var utc_offset_seconds: Int
    var timezone : String
    var timezone_abbreviation: String
    var elevation: Int
    var current_weather: CurrentWeather
    var hourly_units: HourUnits
    var hourly: Hourly
    var daily_units: DailyUnits
    var daily: Daily

    struct CurrentWeather: Decodable {
        var temperature: Double
        var windspeed: Double
        var winddirection: Double
        var weathercode: Int
        var time: String
    }
    
    struct HourUnits: Decodable {
        var time: String
        var apparent_temperature: String
        var relativehumidity_2m: String
    }
    
    struct Hourly: Decodable {
        var time: [String]
        var apparent_temperature: [Double]
        var relativehumidity_2m: [Int]
    }
    
    struct DailyUnits: Decodable {
        var time: String
        var temperature_2m_max: String
        var temperature_2m_min: String
    }
    
    struct Daily: Decodable {
        var time: [String]
        var temperature_2m_max: [Double]
        var temperature_2m_min: [Double]
    }
}

/*
extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
} */
