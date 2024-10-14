//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//

import Foundation

// Структура для прогноза погоды
struct ForecastResponse: Codable {
    let city: City
    let list: [Forecast]
}

// Структура для города
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
}

// Структура для координат
struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

// Структура для отдельного прогноза
struct Forecast: Codable {
    let dt: TimeInterval
    let main: MainWeather
    let weather: [Weather]
}

// Структура для основной информации о погоде
struct MainWeather: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    
}

// Структура для описания погоды
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherForecastModel: Codable {
    let main: Main
    let weather: [Weather]
    let dtTxt: String // Дата и время прогноза
    
    struct Main: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let description: String
        let icon: String
        let main: String
    }
}


struct WeatherResponse: Codable {
    let coord: Coordinates        // Координаты местоположения
    let weather: [Weather]       // Массив с информацией о погоде
    let main: MainWeather         // Основные параметры погоды
    let name: String              // Название города

    // Структура для координат
    struct Coordinates: Codable {
        let lon: Double            // Долгота
        let lat: Double            // Широта
    }

    // Структура для информации о погоде
    struct Weather: Codable {
        let id: Int                // ID погоды
        let main: String           // Основной тип погоды
        let description: String     // Описание погоды
        let icon: String           // Код иконки погоды
    }

    // Структура для основных параметров погоды
    struct MainWeather: Codable {
        let temp: Double           // Температура в градусах Цельсия
        let pressure: Double        // Атмосферное давление
        let humidity: Double        // Влажность
        
    }
}

