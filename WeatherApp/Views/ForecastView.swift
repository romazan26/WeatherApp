//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        List {
            if let forecastList = viewModel.forecast?.list, !forecastList.isEmpty {
                ForEach(forecastList, id: \.dt) { item in
                    VStack(alignment: .leading) {
                        Text("Дата: \(formattedDate(from: item.dt))")
                            .font(.headline)
                        Text("Температура: \(item.main.temp, specifier: "%.1f")°C")
                        Text("Описание: \(item.weather.first?.description.capitalized ?? "Нет данных")")
                        Text("Атмосферное давление: \(item.main.pressure, specifier: "%.1f") hPa")
                        Text("Влажность: \(item.main.humidity, specifier: "%.1f")%")
                    }
                }
            } else {
                Text("Нет данных о прогнозе. Проверьте подключение к интернету.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Прогноз погоды")
    }

    private func formattedDate(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ForecastView(viewModel: WeatherViewModel())
}
