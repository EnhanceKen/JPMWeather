//
//  WeatherView.swift
//  WeatherAppV1
//
//  Created by Consultant on 5/19/23.
//

import SwiftUI

struct WeatherView: View {
    @State var weather: ResponseBody
    @State var searchQuery: String = ""
    var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack{
                Spacer()
                VStack(alignment: .center) {
                    Text(weather.name)
                        .bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .padding(.top, 50)
                Spacer()
                
                VStack {
                    Text("Search")
                    TextField("City Name", text: $searchQuery, onCommit: {
                        Task {
                            do {
                                weather = try await weatherManager.getWeatherByCity(city: searchQuery)
                            } catch {
                                print("Error getting weather for city: \(error)")
                            }
                        }
                    })
                    .padding(10)
                    .frame(height: 40)
                    .background(.white)
                    .cornerRadius(50)
                    
                }
                
                Spacer()
                
                VStack{
                    HStack{
                        VStack(spacing: 20){
                            AsyncImage(url: weather.weather[0].iconURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(weather.weather[0].main)
                        }
                        Spacer()
                        
                        Text(weather.main.feels_like.roundDouble() + "°")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .padding()
                    }
                    .padding()
                        .frame(height: 80)
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2019/08/03/16/20/cartoon-city-4382115_1280.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }
                VStack{
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Weather Now")
                            .bold().padding(.bottom)
                        
                        HStack{
                            WeatherRow(logo: "thermometer", name: "min temp", value: (weather.main.temp_min.roundDouble() + "°"))
                            Spacer()
                            WeatherRow(logo: "thermometer", name: "max temp", value: (weather.main.temp_max.roundDouble() + "°"))
                        }
                        HStack{
                            WeatherRow(logo: "wind", name: "wind speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                            Spacer()
                            WeatherRow(logo: "humidity", name: "humidity", value: (weather.main.humidity.roundDouble() + "%"))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.47, saturation: 0.651, brightness: 0.826))
                    .background(.white)
                    .cornerRadius(20)
                }
                .padding()
            }
            .padding()
           
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.47, saturation: 0.651, brightness: 0.826))
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
