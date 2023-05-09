//
//  ContentView.swift
//  SwiftNetworking
//
//  Created by Jack Yang on 2023/5/6.
//

import SwiftUI

struct ContentView: View {
    //建立WeatherEngine实例
    let weatherEngine = WeatherEngine()
    //建立两个@State字符串变量用以储存“天气类型”和“体感温度”
    @State var weatherMain = "Weather"
    @State var feelsLike = "Temp"
    
    var body: some View {
        VStack {
            //显示体感温度
            Text(String(feelsLike))
                .font(.system(size: 100, weight: .light, design: .serif))
                .multilineTextAlignment(.center)
            //显示天气类型
            Text(weatherMain)
                .font(.system(size: 24))
            //测试打印API地址
            Button(action: {
                weatherEngine.apiUrlCheck()
            }) {
                Text("Fetch Weather Data")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        //是显示时调用fetchWeathData()方法
        .onAppear(){
            weatherEngine.fetchWeathData { result in
                switch result {
                case.success(let weatherData):
                    print(weatherData.weatherMain)
                    print(weatherData.feelsLike)
                    self.weatherMain = weatherData.weatherMain
                    self.feelsLike = String(Int(weatherData.feelsLike)) + "°C"
                case.failure(let error):
                    print("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
