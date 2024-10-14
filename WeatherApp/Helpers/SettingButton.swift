//
//  SettingButton.swift
//  WeatherApp
//
//  Created by Роман on 14.10.2024.
//
import SwiftUI

struct SettingButton: View {
    var text = ""
    var imageName = ""
    var body: some View {
        
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 24, height: 24)
            Spacer()
            Text(text)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    SettingButton(text: "share", imageName: "plus")
}
