//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//
import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: WeatherResponse?
    @Published var forecast: ForecastResponse?
    private var weatherService = WeatherService()

    func fetchCurrentWeather(latitude: Double, longitude: Double) {
        weatherService.fetchCurrentWeather(latitude: latitude, longitude: longitude) { [weak self] weather in
            self?.currentWeather = weather
        }
    }

    func fetchWeatherByCityName(city: String) {
        weatherService.fetchWeatherByCityName(city: city) { [weak self] weather in
            self?.currentWeather = weather
        }
        
        fetchForecastByCityName(city: city)
    }

    func fetchForecastByCityName(city: String) {
        weatherService.fetchForecastByCityName(city: city) { [weak self] forecast in
            self?.forecast = forecast
        }
    }
}
