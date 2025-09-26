//
//  Resort.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Models/Resort.swift
import Foundation
import CoreLocation

struct Resort: Identifiable, Codable {
    // Common identifiers
    let id: String
    let name: String
    
    // Location information
    let state: String
    let region: String
    let latitude: Double
    let longitude: Double
    
    // Visual content
    let imageUrl: String?
    let images: [String]
    
    // Resort statistics
    let elevation: Int?
    let runs: Int?
    let rating: Double?
    let isOpen: Bool
    
    // Pricing
    let ticketCost: Double?
    let fullDayTicket: String
    let halfDayTicket: String
    
    // Run difficulty percentages
    let difficulty: DifficultyInfo
    
    // Resort features
    let terrainPark: String
    let backcountry: Bool?
    let snowmobile: Bool?
    let snowTubing: Bool?
    let iceSkating: Bool?
    let nightSkiing: Bool?
    
    // Content and personalization
    let description: String
    let matchPercentage: Double?
    let scrapeUrl: String
    let url: String
    
    // Weather information
    let weather: WeatherInfo?
    
    // Computed properties for compatibility
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var coordinate: CLLocationCoordinate2D {
        location
    }
    
    // Legacy compatibility
    var shortDescription: String {
        String(description.prefix(100))
    }
    
    var basePrice: Double {
        ticketCost ?? 0
    }
    
    var amenities: [String] {
        var result: [String] = []
        if terrainPark != "No" { result.append("Terrain Park") }
        if backcountry == true { result.append("Backcountry") }
        if snowmobile == true { result.append("Snowmobile") }
        if snowTubing == true { result.append("Snow Tubing") }
        if iceSkating == true { result.append("Ice Skating") }
        if nightSkiing == true { result.append("Night Skiing") }
        return result
    }
    
    var difficultyLevels: [String] {
        var levels: [String] = []
        if difficulty.percent.green != "0%" { levels.append("Beginner") }
        if difficulty.percent.blue != "0%" || difficulty.percent.doubleBlue != "0%" { levels.append("Intermediate") }
        if difficulty.percent.black != "0%" { levels.append("Advanced") }
        if difficulty.percent.doubleBlack != "0%" { levels.append("Expert") }
        return levels
    }
}

// MARK: - Supporting Types
struct DifficultyInfo: Codable {
    let percent: DifficultyPercent
    let distance: DifficultyDistance
}

struct DifficultyPercent: Codable {
    let green: String
    let blue: String
    let doubleBlue: String
    let black: String
    let doubleBlack: String
}

struct DifficultyDistance: Codable {
    let green: String
    let blue: String
    let doubleBlue: String
    let black: String
    let doubleBlack: String
}

struct WeatherInfo: Codable {
    let temperature: Double
    let condition: String
    let snowfall: Double
    
    // Additional fields from NWS API
    let windSpeed: String?
    let windDirection: String?
    let shortForecast: String?
    let detailedForecast: String?
    let icon: String?
}

// MARK: - Mock Data
extension Resort {
    static let mockResorts: [Resort] = [
        Resort(
            id: "sugar-mountain",
            name: "Sugar Mountain",
            state: "NC",
            region: "Southeast",
            latitude: 36.1317,
            longitude: -81.8795,
            imageUrl: "https://example.com/sugar-mountain.jpg",
            images: ["sugar-1", "sugar-2", "sugar-3"],
            elevation: 5300,
            runs: 21,
            rating: 4.2,
            isOpen: true,
            ticketCost: 89.99,
            fullDayTicket: "$89.99",
            halfDayTicket: "$59.99",
            difficulty: DifficultyInfo(
                percent: DifficultyPercent(
                    green: "40%",
                    blue: "30%",
                    doubleBlue: "10%",
                    black: "15%",
                    doubleBlack: "5%"
                ),
                distance: DifficultyDistance(
                    green: "8.5 miles",
                    blue: "6.2 miles",
                    doubleBlue: "2.1 miles",
                    black: "3.1 miles",
                    doubleBlack: "1.0 miles"
                )
            ),
            terrainPark: "Yes - 2 Parks",
            backcountry: false,
            snowmobile: true,
            snowTubing: true,
            iceSkating: true,
            nightSkiing: false,
            description: "Sugar Mountain Resort offers the best skiing and snowboarding in North Carolina with 115 acres of skiable terrain. Perfect for families and beginners, with excellent ski school programs and a variety of winter activities. The resort features state-of-the-art snowmaking covering 100% of the slopes.",
            matchPercentage: 95.0,
            scrapeUrl: "https://skiresort.info/sugar-mountain",
            url: "https://www.skisugar.com",
            weather: WeatherInfo(
                temperature: 28,
                condition: "Partly Cloudy",
                snowfall: 2.5,
                windSpeed: "12 mph",
                windDirection: "NW",
                shortForecast: "Partly cloudy with light snow",
                detailedForecast: "Partly cloudy with light snow expected in the afternoon. Winds NW at 10-15 mph.",
                icon: "snow"
            )
        ),
        Resort(
            id: "steamboat-springs",
            name: "Steamboat Springs",
            state: "CO",
            region: "Rocky Mountains",
            latitude: 40.4850,
            longitude: -106.8317,
            imageUrl: "https://example.com/steamboat.jpg",
            images: ["steamboat-1", "steamboat-2", "steamboat-3"],
            elevation: 10568,
            runs: 169,
            rating: 4.7,
            isOpen: true,
            ticketCost: 280,
            fullDayTicket: "$280.00",
            halfDayTicket: "$180.00",
            difficulty: DifficultyInfo(
                percent: DifficultyPercent(
                    green: "14%",
                    blue: "42%",
                    doubleBlue: "12%",
                    black: "26%",
                    doubleBlack: "6%"
                ),
                distance: DifficultyDistance(
                    green: "12.3 miles",
                    blue: "36.8 miles",
                    doubleBlue: "10.5 miles",
                    black: "22.8 miles",
                    doubleBlack: "5.3 miles"
                )
            ),
            terrainPark: "Yes - 3 Progressive Parks",
            backcountry: true,
            snowmobile: true,
            snowTubing: true,
            iceSkating: false,
            nightSkiing: true,
            description: "Home to Champagne Powder® snow, Steamboat is a complete mountain resort with 2,965 acres of skiable terrain. Known for its legendary snow quality, tree skiing, and western hospitality. The resort offers something for every level, from gentle groomers to challenging mogul runs and gladed terrain.",
            matchPercentage: 88.0,
            scrapeUrl: "https://skiresort.info/steamboat",
            url: "https://www.steamboat.com",
            weather: WeatherInfo(
                temperature: 18,
                condition: "Heavy Snow",
                snowfall: 8.0,
                windSpeed: "20 mph",
                windDirection: "W",
                shortForecast: "Heavy snow throughout the day",
                detailedForecast: "Heavy snow expected with 6-10 inches of accumulation. Winds W at 15-25 mph with gusts up to 35 mph.",
                icon: "snow_heavy"
            )
        ),
        Resort(
            id: "vail",
            name: "Vail",
            state: "CO",
            region: "Rocky Mountains",
            latitude: 39.6061,
            longitude: -106.3550,
            imageUrl: "https://example.com/vail.jpg",
            images: ["vail-1", "vail-2", "vail-3", "vail-4", "vail-5"],
            elevation: 11570,
            runs: 195,
            rating: 4.8,
            isOpen: true,
            ticketCost: 450,
            fullDayTicket: "$450.00",
            halfDayTicket: "$320.00",
            difficulty: DifficultyInfo(
                percent: DifficultyPercent(
                    green: "18%",
                    blue: "29%",
                    doubleBlue: "8%",
                    black: "32%",
                    doubleBlack: "13%"
                ),
                distance: DifficultyDistance(
                    green: "28.5 miles",
                    blue: "45.9 miles",
                    doubleBlue: "12.7 miles",
                    black: "50.6 miles",
                    doubleBlack: "20.6 miles"
                )
            ),
            terrainPark: "Yes - Golden Peak Terrain Park",
            backcountry: true,
            snowmobile: false,
            snowTubing: true,
            iceSkating: true,
            nightSkiing: false,
            description: "Vail Mountain is legendary with its 5,317 acres of developed ski and snowboard terrain, including seven legendary Back Bowls. One of the world's premier ski destinations, offering luxury amenities, world-class dining, and some of the most varied terrain in North America. The resort features pristine groomed runs, mogul fields, glades, and terrain parks.",
            matchPercentage: 72.0,
            scrapeUrl: "https://skiresort.info/vail",
            url: "https://www.vail.com",
            weather: WeatherInfo(
                temperature: 12,
                condition: "Clear",
                snowfall: 0,
                windSpeed: "8 mph",
                windDirection: "N",
                shortForecast: "Clear and cold",
                detailedForecast: "Clear skies with very cold temperatures. Winds light and variable. Perfect bluebird day for skiing.",
                icon: "clear"
            )
        )
    ]
}
