//
//  MapView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 21/08/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
            Map(initialPosition: .region(region))
        }

        private var region: MKCoordinateRegion {
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 40.821_503, longitude: -81.397_874),
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            )
        }
}

#Preview {
    MapView()
}
