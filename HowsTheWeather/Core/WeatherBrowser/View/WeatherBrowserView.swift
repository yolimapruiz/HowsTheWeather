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
    @State private var showError: Bool = false
    //var initialCity: String
    
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
                    Spacer()
                }
                
                HStack {
                    TextField("Search City", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .submitLabel(.search)
                        .onSubmit {
                            viewModel.getWeather(for: searchText)
                            searchText = ""
                        }
                    
                    Button(action: {
                        viewModel.getWeather(for: searchText)
                        searchText = ""
                        
                    }) {
                        Text("Search")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
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
            
        }
    }

    
    // weather information (city name and temperature)
    private var weatherInfoColumn: some View {
        VStack {
           
            Text(currentWeather?.name ?? weatherDefault.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text("\(Int(currentWeather?.temp ?? weatherDefault.temp))°F")
                .font(.system(size: 70))
                .fontWeight(.thin)
                .foregroundColor(.red)
            
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
                } else {
                    ProgressView()
                }
            }
            
            Text(currentWeather?.description ?? weatherDefault.description)
                .font(.title3)
                .foregroundColor(.green)
            
            // Max and Min temperatures
            HStack {
                Text("Max: \(Int(currentWeather?.maxTemp ?? weatherDefault.maxTemp))°F")
                    .font(.title3)
                Spacer()
                Text("Min: \(Int(currentWeather?.minTemp ?? weatherDefault.minTemp))°F")
                    .font(.title3)
            }
            .padding(.horizontal, 20)
            
            // Feels like
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
    }
}

#Preview {
    WeatherBrowserView(viewModel: weatherViewModelMock)
        .previewInterfaceOrientation(.portraitUpsideDown)

}
