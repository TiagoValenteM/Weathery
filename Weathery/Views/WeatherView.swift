//
//  WeatherView.swift
//  Weathery
//
//  Created by Tiago Valente on 29/01/2023.
//

import SwiftUI

struct WeatherView: View{
    
    func GetIcon(weathercode: Int) -> (String, String){
        let WeatherSymbolDescription: Dictionary<Int, (String,String)> = [0: ("sun.max.fill","Clear sky"),
                                                                        1: ("cloud.sun.fill","Mainly clear"),
                                                                        2:("cloud.sun.fill","Partly cloudy"),
                                                                        3:("cloud.sun.fill","Overcast"),
                                                                        45:("cloud.fog.fill","Fog"),
                                                                        48:("cloud.fog.fill","Depositing Rime Fog"),
                                                                        51:("cloud.drizzle.fill","Light Drizzle"),
                                                                        53:("cloud.drizzle.fill","Moderate Drizzle"),
                                                                        55:("cloud.drizzle.fill","Dense Drizzle"),
                                                                        56: ("cloud.drizzle.fill","Light Freezing Drizzle"),
                                                                        57: ("cloud.drizzle.fill","Dense Freezing Drizzle"),
                                                                        61: ("cloud.rain.fill","Slight Rain"),
                                                                        63: ("cloud.rain.fill","Moderate Rain"),
                                                                        65: ("cloud.rain.fill","Heavy Rain"),
                                                                        66: ("cloud.hail.fill","Light Freezing Rain"),
                                                                        67: ("cloud.hail.fill","Heavy Freezing Rain"),
                                                                        71: ("cloud.snow.fill","Slight Snow Fall"),
                                                                        73: ("cloud.snow.fill","Moderate Snow Fall"),
                                                                        75: ("cloud.snow.fill","Violent Snow Fall"),
                                                                        77: ("cloud.snow.fill","Snow Grains"),
                                                                        80: ("cloud.heavyrain.fill","Slight Rain Showers"),
                                                                        81: ("cloud.heavyrain.fill","Moderate Rain Showers"),
                                                                        82: ("cloud.heavyrain.fill","Violent Rain Showers"),
                                                                        85: ("cloud.sleet.fill","Slight Snow Showers"),
                                                                        86: ("cloud.sleet.fill","Heavy Snow Showers"),
                                                                        95: ("cloud.bolt.fill","Thunderstorm"),
                                                                        96: ("cloud.bolt.rain.fill","Thunderstorm with Slight Hail"),
                                                                        99: ("cloud.bolt.rain.fill","Thunderstorm with Heavy Hail")]
        
        let Symbol = WeatherSymbolDescription[weathercode]?.0 ?? "sun.max"
        let Description = WeatherSymbolDescription[weathercode]?.1 ?? "Partly cloudy"
                
        return (Symbol,Description)
    }
    
    var weather: ResponseBody
    var placemark: String
    
    var body: some View{
        ZStack(alignment: .leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(placemark)
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
                            Image(systemName:GetIcon(weathercode: weather.current_weather.weathercode).0)
                                .font(.system(size: 50))
                                .padding(.horizontal, 20)
                            
                            Text(GetIcon(weathercode: weather.current_weather.weathercode).1)
                            
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(String(weather.current_weather.temperature.roundDouble()) + "º")
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
                        WeatherRow(logo: "thermometer.low", name: "Min Temp", value: (weather.daily.temperature_2m_min[0].roundDouble() + "º"))
                        Spacer()
                        WeatherRow(logo: "thermometer.high", name: "Max Temp", value: (weather.daily.temperature_2m_max[0].roundDouble() + "º"))
                    }.padding(.horizontal)
                    
                    HStack(alignment: .center){
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.current_weather.windspeed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidty", value: (String(weather.hourly.relativehumidity_2m[0]) + "%"))
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
        WeatherView(weather: previewWeather, placemark: "London")
    }
}
