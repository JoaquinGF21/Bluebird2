//
//  ResortWeatherBar.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Components/ResortWeatherBar.swift
import SwiftUI

struct ResortWeatherBar: View {
    let weather: WeatherInfo
    
    var body: some View {
        HStack(spacing: 20) {
            WeatherMetric(
                icon: "thermometer",
                value: "\(Int(weather.temperature))°F",
                label: weather.condition
            )
            
            Divider()
                .frame(height: 30)
            
            WeatherMetric(
                icon: "snowflake",
                value: String(format: "%.1f\"", weather.snowfall), // Fixed: using String format
                label: "New Snow"
            )
            
            if let windSpeed = weather.windSpeed {
                Divider()
                    .frame(height: 30)
                
                WeatherMetric(
                    icon: "wind",
                    value: windSpeed,
                    label: weather.windDirection ?? ""
                )
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
    }
}

private struct WeatherMetric: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(value)
                    .fontWeight(.semibold)
            }
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
