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
    @State private var downloadedImage: UIImage?
    
    private var currentWeather: WeatherModel? {
        viewModel.weather
    }
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            VStack {
                HStack {
                    Text("How's the Weather?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .accessibilityAddTraits(.isHeader)
                    Spacer()
                }
                
                HStack {
                    TextField("Search City", text: $searchText)
                        .accessibilityIdentifier("search_city_identifier")
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .submitLabel(.search)
                        .onSubmit {
                            viewModel.getWeather(for: searchText)
                            searchText = ""
                        }
                        .accessibilityLabel("Search city")
                        .accessibilityHint("Enter the name of city and press search")
                    
                    Button(action: {
                        viewModel.getWeather(for: searchText)
                        searchText = ""
                        
                    }) {
                        Text("Search")
                            .accessibilityIdentifier("search_button_identifier")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .accessibilityLabel("Search button")
                    .accessibilityHint("Fetch the weather for the entered city")
                }
                
                if isLandscape {
                    // layout for landscape support
                    HStack(alignment: .top) {
                        weatherInfoColumn
                        weatherDetailsColumn
                    }
                    .padding(.horizontal, 20)
                } else {
                    // layout for portrait support
                    VStack {
                        weatherInfoColumn
                        weatherDetailsColumn
                    }
                    .padding(.horizontal, 20)
                }
                
            }
            .padding()
            .alert(item: $viewModel.ErrorMessage) { errorMessage in
                
                Alert(title: Text("An error has occurred"),
                                  message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
            
            
            
            .onAppear {
                viewModel.loadInitialWeather()
            }
            
            .listStyle(PlainListStyle())
            
        }
    }

    
    // weather information (city name and temperature)
    private var weatherInfoColumn: some View {
        VStack {
           
            Text(currentWeather?.name ?? weatherDefault.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .accessibilityLabel("City Name")
                .accessibilityValue(currentWeather?.name ?? weatherDefault.name)

            Text("\(Int(currentWeather?.temp ?? weatherDefault.temp))°F")
                .font(.system(size: 70))
                .fontWeight(.thin)
                .foregroundColor(.red)
                .accessibilityLabel("Temperature")
                .accessibilityValue("\(Int(currentWeather?.temp ?? weatherDefault.temp)) degrees Fahrenheit")
            
        }
    }
    
    // additional weather information
    private var weatherDetailsColumn: some View {
        VStack {
            // weather icon and description
            HStack {
                
                if let imageData = currentWeather?.iconImageData, let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .accessibilityLabel("Weather icon")
                } else {
                    ProgressView()
                }
            }
            
            Text(currentWeather?.description ?? weatherDefault.description)
                .font(.title3)
                .foregroundColor(.green)
                .accessibilityLabel("Weather description")
                .accessibilityValue(currentWeather?.description ?? weatherDefault.description)
            
            // Max and Min temperatures
            HStack {
                Text("Max: \(Int(currentWeather?.maxTemp ?? weatherDefault.maxTemp))°F")
                    .font(.title3)
                    .accessibilityLabel("Maximum temperature")
                    .accessibilityValue("\(Int(currentWeather?.maxTemp ?? weatherDefault.maxTemp)) degrees Fahrenheit")
                
                Spacer()
                Text("Min: \(Int(currentWeather?.minTemp ?? weatherDefault.minTemp))°F")
                    .font(.title3)
                    .accessibilityLabel("Minimum temperature")
                    .accessibilityValue("\(Int(currentWeather?.minTemp ?? weatherDefault.minTemp)) degrees Fahrenheit")
            }
            .padding(.horizontal, 20)
            
            // Feels like
            VStack {
                Text("Feels like")
                    .font(.headline)
                    .accessibilityLabel("Feels like temperature")
                
                Text("\(Int(currentWeather?.feelsLikeTemp ?? weatherDefault.feelsLikeTemp))°F")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .accessibilityValue("\(Int(currentWeather?.feelsLikeTemp ?? weatherDefault.feelsLikeTemp)) degrees Fahrenheit")
            }
            .padding(.top, 20)
            
            // Humidity and pressure
            HStack {
                VStack {
                    Text("Humidity")
                    Text("\(Int(currentWeather?.humidity ?? weatherDefault.humidity))%")
                        .font(.title2)
                        .accessibilityLabel("Humidity")
                        .accessibilityValue("\(Int(currentWeather?.humidity ?? weatherDefault.humidity)) percent")
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                VStack {
                    Text("Pressure")
                    Text("\(Int(currentWeather?.pressure ?? weatherDefault.pressure)) hPa")
                        .font(.title2)
                        .accessibilityLabel("Pressure")
                        .accessibilityValue("\(Int(currentWeather?.pressure ?? weatherDefault.pressure)) hPa")
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .padding(.top, 20)
        }
    }
}


#Preview("English") {
    
    WeatherBrowserView(viewModel: weatherViewModelMock)
            .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Spanish") {
    WeatherBrowserView(viewModel: weatherViewModelMock)
        .environment(\.locale, Locale(identifier: "ES"))
}
