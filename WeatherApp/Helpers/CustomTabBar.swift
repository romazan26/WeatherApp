//
//  CustomTabBar.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        HStack {
            TabBarButton(tab: .main, selectedTab: $selectedTab)
            TabBarButton(tab: .forecast, selectedTab: $selectedTab)

            // Central Button
            Button(action: {
                // Действие для центральной кнопки
                selectedTab = .main
                print("Central Button Pressed")
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding(.bottom, 20)

            TabBarButton(tab: .chart, selectedTab: $selectedTab)
            TabBarButton(tab: .settings, selectedTab: $selectedTab)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct TabBarButton: View {
    var tab: Tab
    @Binding var selectedTab: Tab

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: tab.iconName)
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == tab ? Color.blue : Color.gray)
                Text(tab.title)
                    .font(.footnote)
                    .foregroundColor(selectedTab == tab ? Color.blue : Color.gray)
            }
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
    }
}

enum Tab {
    case main
    case forecast
    case chart
    case settings

    var title: String {
        switch self {
        case .main: return "Main"
        case .forecast: return "Forecast"
        case .chart: return "Chart"
        case .settings: return "Settings"
        }
    }

    var iconName: String {
        switch self {
        case .main: return "thermometer"
        case .forecast: return "calendar"
        case .chart: return "chart.bar.fill"
        case .settings: return "gearshape"
        }
    }
}
