//
//  MainContentView.swift
//  WeatherApp
//
//  Created by Роман on 14.10.2024.
//
import SwiftUI

struct MainContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @EnvironmentObject var locationManager: LocationManager
    @Binding var city: String
    @FocusState var keyboard: Bool

    var body: some View {
        VStack {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                ProgressView("Запрашиваем доступ к местоположению...")
                    .onAppear {
                        locationManager.startUpdatingLocation()
                    }
            case .denied, .restricted:
                Text("Доступ к местоположению запрещен. Пожалуйста, разрешите доступ в настройках.")
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Открыть настройки") {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                }
            case .authorizedWhenInUse, .authorizedAlways:
                if let weather = viewModel.currentWeather {
                    VStack {
                               // Проверяем, есть ли текущая погода
                               if let currentWeather = viewModel.currentWeather {
                                   // Отображение текущего населенного пункта
                                   Text("Город: \(currentWeather.name)")
                                       .font(.largeTitle)
                                       .padding()

                                   // Отображение иконки погоды
                                   if let icon = currentWeather.weather.first?.icon {
                                          WeatherImage(icon: icon)
                                      } else {
                                          Text("Иконка не найдена")
                                      }

                                   // Отображение текущей температуры
                                   Text("Температура: \(currentWeather.main.temp, specifier: "%.1f")°C")
                                       .font(.title)
                                       .padding()

                                   // Рекомендации
                                   Text(getRecommendation(for: currentWeather.main.temp))
                                       .font(.subheadline)
                                       .padding()
                               } else {
                                   Text("Загружаем данные о погоде...")
                               }
                           }
                    .padding()
                            .onAppear {
                                viewModel.fetchCurrentWeather(latitude: 0.0, longitude: 0.0)
                            }
                } else if locationManager.location == nil {
                    ProgressView("Получаем местоположение...")
                } else {
                    ProgressView("Загружаем данные о погоде...")
                        .onAppear {
                            if let location = locationManager.location {
                                viewModel.fetchCurrentWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            }
                        }
                }

                // Поле для ввода города и кнопка поиска
                VStack {
                    TextField("Введите город", text: $city)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .focused($keyboard)

                    Button(action: {
                        viewModel.fetchWeatherByCityName(city: city)
                    }) {
                        Text("Поиск по городу")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            default:
                Text("Неизвестное состояние местоположения.")
            }
        }
        .onTapGesture {
            keyboard = false
        }
    }
    // Метод для получения рекомендации в зависимости от температуры
        func getRecommendation(for temperature: Double) -> String {
            switch temperature {
            case let temp where temp < 0:
                return "Температура ниже 0 градусов."
            case 0..<15:
                return "Температура от 0 до 15 градусов."
            case 15...:
                return "Температура выше 15 градусов."
            default:
                return "Нет данных о погоде."
            }
        }
}
