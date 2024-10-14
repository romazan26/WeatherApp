//
//  ContentView.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//
import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .main
    @StateObject private var viewModel = WeatherViewModel()
    @EnvironmentObject var locationManager: LocationManager
    @State private var city: String = ""

    var body: some View {
        VStack {
            switch selectedTab {
            case .main:
                MainContentView(viewModel: viewModel, city: $city)
            case .forecast:
                NavigationView {
                    ForecastView(viewModel: viewModel)
                }
            case .chart:
                ChartWeatherView(viewModel: viewModel)
            case .settings:
                SettingsView()
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)  // Используем кастомный TabBar
        }
    }
}


