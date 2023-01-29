//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tiago Valente on 27/01/2023.
//

import SwiftUI


    
struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location{
                if let weather = weather{
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do{
                                try await weatherManager.getCurrentWeather(latitude:location.latitude, longitude: location.longitude)
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
