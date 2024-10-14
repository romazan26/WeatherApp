//
//  ChartWeatherView.swift
//  WeatherApp
//
//  Created by Роман on 14.10.2024.
//

import SwiftUI
import SwiftUICharts

struct ForecastDataPoint {
    let date: Date
    let temperature: Double
}

struct ChartWeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
       @State private var forecastData: [ForecastDataPoint] = []
       
    var body: some View {
        VStack {
            if !forecastData.isEmpty {
                // Создание массива данных для графика
                let dataEntries: [Double] = forecastData.map { $0.temperature }
                
                // Создание данных для графика
                let barChartData = BarChartData(dataSets: createDataSet(data: dataEntries))
                
                Spacer()
                
                // Отображение столбчатого графика
                BarChart(chartData: barChartData)
                    .frame(height: 300)
                    .padding()
                Spacer()
            } else {
                Text("Загружаем прогноз погоды...")
                    .onAppear {
                        fetchForecast()
                    }
            }
        }
                
    }
    
    func createGoodDataSet(data:[ForecastDataPoint]) -> BarDataSet {
        var entriesBar: [BarChartDataPoint] = []
        for forecastData in data {
            entriesBar.append(BarChartDataPoint(value: forecastData.temperature, date: forecastData.date))
        }
        let dataSet = BarDataSet(dataPoints: entriesBar)
        return dataSet
    }
    
    func createDataSet(data: [Double]) -> BarDataSet {
        // Создание набора данных для графика
        let entries = data.enumerated().map { index, temperature in
            BarChartDataPoint(value: temperature, xAxisLabel: String(index))
        }
        
        let dataSet = BarDataSet(dataPoints: entries)
        return dataSet
    }
    func fetchForecast() {
        
        if let forecastList = viewModel.forecast?.list, !forecastList.isEmpty {
            DispatchQueue.main.async {
                self.forecastData = forecastList.map { forecast in
                    let date = Date(timeIntervalSince1970: Double(forecast.dt))
                    return ForecastDataPoint(date: date, temperature: forecast.main.temp)
                }
            }
        }
    }
       
}

#Preview {
    ChartWeatherView(viewModel: WeatherViewModel())
}
