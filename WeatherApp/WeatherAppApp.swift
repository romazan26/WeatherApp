//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Роман on 13.10.2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(locationManager)
        }
    }
}
