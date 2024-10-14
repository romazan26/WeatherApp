//
//  WeatherImage.swift
//  WeatherApp
//
//  Created by Роман on 14.10.2024.
//

import SwiftUI

struct WeatherImage: View {
    let icon: String

    var body: some View {
        let iconURLString = "http://openweathermap.org/img/wn/\(icon)@2x.png"

        AsyncImage(url: URL(string: iconURLString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            case .failure(let error):
                Text("Ошибка загрузки: \(error.localizedDescription)")
            @unknown default:
                // На случай, если есть неизвестный случай
                EmptyView()
            }
        }
    }
}
