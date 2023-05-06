//
//  ContentView.swift
//  SwiftNetworking
//
//  Created by Jack Yang on 2023/5/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                fetchWeatherData()
            }) {
                Text("Fetch Weather Data")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
//        .onAppear(){
//            fetchWeatherData()
//        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
