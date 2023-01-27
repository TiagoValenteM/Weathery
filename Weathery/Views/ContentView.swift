//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tiago Valente on 27/01/2023.
//

import SwiftUI


    
struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        VStack {
            
            if let location = locationManager.location{
                Text("Your coordinates are:\(location.longitude),\(location.latitude)")
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
