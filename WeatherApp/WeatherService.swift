//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//

import Foundation
import CoreLocation
///"c600c6c38269fe8d7f13e5ba0589febf"



class WeatherService {
    let apiKey = "c600c6c38269fe8d7f13e5ba0589febf"

    func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса данных: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("Нет данных от API")
                completion(nil)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print("Ошибка декодирования данных: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchWeatherByCityName(city: String, completion: @escaping (WeatherResponse?) -> Void) {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"

            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
                print("Неверный URL для города")
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Ошибка запроса данных: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                guard let data = data else {
                    print("Нет данных от API")
                    completion(nil)
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                } catch {
                    print("Ошибка декодирования данных: \(error.localizedDescription)")
                    completion(nil)
                }
            }.resume()
        }
    
    func fetchForecastByCityName(city: String, completion: @escaping (ForecastResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            print("Неверный URL для прогноза города")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса данных: \(error.localizedDescription)")
                // Попробуем загрузить данные из UserDefaults, если есть ошибка
                if let cachedForecast = self.loadForecastFromUserDefaults(for: city) {
                    DispatchQueue.main.async {
                        completion(cachedForecast)
                    }
                } else {
                    completion(nil)
                }
                return
            }

            guard let data = data else {
                print("Нет данных от API")
                completion(nil)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                // Сохраним данные в UserDefaults
                self.saveForecastToUserDefaults(forecast: decodedData, for: city)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print("Ошибка декодирования данных: \(error.localizedDescription)")
                // Если произошла ошибка, попытаемся загрузить кэш
                if let cachedForecast = self.loadForecastFromUserDefaults(for: city) {
                    DispatchQueue.main.async {
                        completion(cachedForecast)
                    }
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }

    // Сохранение прогноза в UserDefaults
    private func saveForecastToUserDefaults(forecast: ForecastResponse, for city: String) {
        if let encoded = try? JSONEncoder().encode(forecast) {
            UserDefaults.standard.set(encoded, forKey: "Forecast_\(city)")
        }
    }

    // Загрузка прогноза из UserDefaults
    private func loadForecastFromUserDefaults(for city: String) -> ForecastResponse? {
        if let data = UserDefaults.standard.data(forKey: "Forecast_\(city)"),
           let decoded = try? JSONDecoder().decode(ForecastResponse.self, from: data) {
            return decoded
        }
        return nil
    }
}
