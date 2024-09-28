//
//  WeatherBrowserView.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//
import SwiftUI

struct WeatherBrowserView: View {
    @State private var searchText: String = ""
    @State private var currentWeather = weatherMock  
    
    var body: some View {
        VStack {
            HStack{
                TextField("Search City", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: { 
                    searchForCity()
                }) {
                    Text("Search")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            // City name
            Text(currentWeather.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Temperature
            Text("\(Int(currentWeather.temp))°F")
                .font(.system(size: 70))
                .fontWeight(.thin)
                .foregroundColor(.red)
            
            // weather icon and description
            HStack {
                if let url = URL(string: currentWeather.iconImageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(currentWeather.description)
                    .font(.title3)
                    .foregroundColor(.green)
            }

            // More info about the weather
            HStack {
                Text("Max: \(Int(currentWeather.maxTemp))°F")
                    .font(.title3)
                Spacer()
                Text("Min: \(Int(currentWeather.minTemp))°F")
                    .font(.title3)
            }
            .padding(.horizontal, 20)

            // Sensación térmica
            VStack {
                Text("Feels like")
                    .font(.headline)
                Text("\(Int(currentWeather.feelsLikeTemp))°F")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
            }
            .padding(.top, 20)

            // Humidity and pressure
            HStack {
                VStack {
                    Text("Humidity")
                    Text("\(Int(currentWeather.humidity))%")
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                .padding()

                VStack {
                    Text("Pressure")
                    Text("\(Int(currentWeather.pressure)) hPa")
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .padding(.top, 20)
        }
        .padding()
        .searchable(text: $searchText, prompt: "Buscar ciudad")  // Modificador searchable
        .onSubmit(of: .search) {
            searchForCity()
        }
    }

    // Simular la búsqueda de una nueva ciudad
    func searchForCity() {
        // Aquí puedes implementar tu lógica para actualizar el `currentWeather` con los datos de una nueva ciudad
        // Por ahora, simplemente simula que has buscado "Nueva York" cambiando el mock

        if searchText.lowercased() == "new york" {
            currentWeather = WeatherModel(id: 1000,
                                          name: "New York",
                                          temp: 24,
                                          iconImageUrl: "https://openweathermap.org/img/wn/04d@2x.png",
                                          description: "overcast clouds",
                                          maxTemp: 26,
                                          minTemp: 20,
                                          feelsLikeTemp: 25,
                                          humidity: 65,
                                          pressure: 1010)
        } else if searchText.lowercased() == "miami" {
            currentWeather = WeatherModel(id: 2000,
                                          name: "Miami",
                                          temp: 30,
                                          iconImageUrl: "https://openweathermap.org/img/wn/02d@2x.png",
                                          description: "few clouds",
                                          maxTemp: 32,
                                          minTemp: 28,
                                          feelsLikeTemp: 33,
                                          humidity: 80,
                                          pressure: 1005)
        } else {
            // Si no encuentra la ciudad, resetea a un clima por defecto
            currentWeather = weatherMock
        }
    }
}

#Preview {
    WeatherBrowserView()
}
