//
//  ContentView.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var weatherViewMod: WeatherViewModel
    @State private var city: String = ""
    
    init(weatherViewMod: WeatherViewModel = WeatherViewModel()) {
        self.weatherViewMod = weatherViewMod
    }
    
    var body: some View {
        
        VStack {
            
            TextField("Search", text: self.$city, onEditingChanged: { _ in }, onCommit: {
                self.weatherViewMod.fetchWeather(city: self.city)
                
            }).textFieldStyle(RoundedBorderTextFieldStyle())
               
            Spacer()
             if self.weatherViewMod.loadingState == .success {
                WeatherView(weatherVM: self.weatherViewMod)
            } else if self.weatherViewMod.loadingState == .failed {
                 ErrorView(message: self.weatherViewMod.message)
            }
            
            Spacer()
           
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewM = WeatherViewModel()
        viewM.loadingState = .none
        viewM.message = "არ მოიძებნა"
        
        return ContentView(weatherViewMod: viewM)
    }
}

struct WeatherView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("ტემპერატურა - \(self.weatherVM.temperature)")
                .opacity(1.0)
                .font(.title2)
                .foregroundColor(Color.white)
            Text("ტენიანობა - \(self.weatherVM.humidity)")
                .foregroundColor(Color.white)
                .opacity(0.7)
            
            Picker(selection: self.$weatherVM.temperatureUnit, label: Text("Select a Unit")) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text(unit.title)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
        }
        .padding()
        .frame(width:250, height: 160)
        .background(Color.green)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        
    }
    
}


struct ErrorView: View {
    
    let message: String
    
   var body: some View {
       VStack {
           Text(message)
               .font(.body)
               .foregroundColor(Color.white)
         
       }
       .padding()
       .frame(width:250, height: 160)
       .background(Color.gray)
       .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
   
   }
}
