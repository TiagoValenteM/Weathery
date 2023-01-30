//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tiago Valente on 27/01/2023.
//

import SwiftUI
import CoreLocation

    
struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    
    @State var weather: ResponseBody?
    @State var placemark: CLPlacemark?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                let currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                if let weather = weather {
                    WeatherView(weather: weather, placemark: placemark?.name ?? "Lisbon")
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude:location.latitude, longitude: location.longitude)
                                let placemarkResult = try await locationManager.reverseGeocodeLocation(location: currentLocation)
                                placemark = placemarkResult.first
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading{
                    LoadingView()
                } else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Image("gradientBackground").scaledToFit())
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

