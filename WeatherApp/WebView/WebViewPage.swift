//
//  WebViewPage.swift
//  AircraftInspection
//
//  Created by Роман on 10.04.2024.
//

import SwiftUI

struct WebViewPage: View {
    @State private var isLoading = true
    @Environment(\.dismiss) var dismiss
    let urlString: URL
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            WebView(urlString: urlString, isLoading: $isLoading)
            if isLoading {
                ProgressView()
                    .padding(.leading,180)
                    .padding(.top, 350)
            }
            Button("Back") {
                dismiss()
            }
            .padding(10)
            .buttonStyle(.bordered)
        }
        
    }
}

#Preview {
    WebViewPage(urlString: URL(string: "www.google.com")!)
}
