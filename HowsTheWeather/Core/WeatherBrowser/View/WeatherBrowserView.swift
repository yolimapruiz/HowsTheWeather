//
//  WeatherBrowserView.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//
import SwiftUI

struct WeatherBrowserView: View {
    
    @StateObject var viewModel: WeatherViewModel
    
    @State private var searchText: String = ""
    var initialCity: String
    
    private var currentWeather: WeatherModel? {
        viewModel.weather
    }
    
    var body: some View {
        VStack {
            
            HStack{
                Text("How's the Weather?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Spacer()
            }
            
            HStack{
                TextField("Search City", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .submitLabel(.search)
                    .onSubmit {
                        viewModel.getWeather(for: searchText)
                    }
                
                Button(action: { 
                    //searchForCity()
                    viewModel.getWeather(for: searchText)
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
            Text(currentWeather?.name ?? weatherDefault.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Temperature
            Text("\(Int(currentWeather?.temp ?? weatherDefault.temp))°F")
                .font(.system(size: 70))
                .fontWeight(.thin)
                .foregroundColor(.red)
            
            // weather icon and description
            HStack {
                if let url = URL(string: currentWeather?.iconImageUrl ?? weatherDefault.iconImageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(currentWeather?.description ?? weatherDefault.description)
                    .font(.title3)
                    .foregroundColor(.green)
            }

            // More info about the weather
            HStack {
                Text("Max: \(Int(currentWeather?.maxTemp ?? weatherDefault.maxTemp))°F")
                    .font(.title3)
                Spacer()
                Text("Min: \(Int(currentWeather?.minTemp ?? weatherDefault.minTemp))°F")
                    .font(.title3)
            }
            .padding(.horizontal, 20)

            // Sensación térmica
            VStack {
                Text("Feels like")
                    .font(.headline)
                Text("\(Int(currentWeather?.feelsLikeTemp ?? weatherDefault.feelsLikeTemp))°F")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
            }
            .padding(.top, 20)

            // Humidity and pressure
            HStack {
                VStack {
                    Text("Humidity")
                    Text("\(Int(currentWeather?.humidity ?? weatherDefault.humidity))%")
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                .padding()

                VStack {
                    Text("Pressure")
                    Text("\(Int(currentWeather?.pressure ?? weatherDefault.pressure)) hPa")
                        .font(.title2)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .padding(.top, 20)
        }
        .padding()
        .onAppear {
            viewModel.getWeather(for: initialCity)
        }
    }

}

#Preview {
    WeatherBrowserView(viewModel: weatherViewModelMock, initialCity: "Dallas")
}
