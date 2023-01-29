//
//  WeatherView.swift
//  Weathery
//
//  Created by Tiago Valente on 29/01/2023.
//

import SwiftUI

struct WeatherView: View{
    var weather: ResponseBody
    
    var body: some View{
        ZStack(alignment: .leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    
                    Text("Today,\(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading])
                
                Spacer()
                
                VStack{
                    HStack{
                        VStack(spacing: 20){
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                            
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "º")
                            .font(.system(size: 80))
                            .fontWeight(.bold)
                            .padding()
                            }.padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL (string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")){
                        image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    }placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 25)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                Spacer()

                VStack(alignment: .leading, spacing: 20){
                    Text("Weather Now")
                        .bold().padding(.bottom).fontWeight(.bold)
                    
                    HStack(alignment: .center){
                        WeatherRow(logo: "thermometer", name: "Min Temp", value: (weather.main.tempMin.roundDouble() + "º"))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max Temp", value: (weather.main.temp_max.roundDouble() + "º"))
                    }.padding(.horizontal)
                    
                    HStack(alignment: .center){
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidty", value: (weather.main.humidity.roundDouble() + "%"))
                    }.padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(20, corners:[
                    .topLeft,.topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Image("gradientBackground").scaledToFit())
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View{
        WeatherView(weather: previewWeather)
    }
}
