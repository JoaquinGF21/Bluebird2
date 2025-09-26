//
//  MapAnnotation.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/15/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/Map/MapAnnotation.swift
import SwiftUI
import MapKit

struct ResortAnnotation: View {
    let resort: Resort
    @State private var showDetails = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom marker icon
            Image(systemName: "snowflake.circle.fill")
                .font(.title)
                .foregroundColor(.blue)
                .background(Circle().fill(Color.white).frame(width: 30, height: 30))
                .shadow(radius: 3)
                .onTapGesture {
                    showDetails.toggle()
                }
            
            // Resort name label (always visible)
            Text(resort.name)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
                .offset(y: -5)
        }
    }
}

// For more advanced annotation with MKAnnotationView (if needed)
class ResortAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            guard annotation is MKPointAnnotation else { return }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            image = UIImage(systemName: "snowflake.circle.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        }
    }
}
