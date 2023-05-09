//
//  WeatherEngine.swift
//  SwiftNetworking
//
//  Created by Jack Yang on 2023/5/6.
//

import Foundation

//var tempNow 

func fetchWeatherData() {
    print("-----API call runs here-----")
    //API请求地址
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=35.18147&lon=136.90641&appid=\(API_KEY)") else {
        print("Invalid URL")
        return
    }
    
    //建立URLRequest对象，请求方式为GET
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    //建立URLSession dataTask来请求API并获取返回结果
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //异常返回
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        //Http响应异常
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            return
        }
        
        //获得200(OK)响应，处理返回数据
        if httpResponse.statusCode == 200 {
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let weatherData = json as? [String: Any] {
                        //处理返回的data数据
                        print("Weather data: \(weatherData)")
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        } else {
            print("API request error with code: \(httpResponse.statusCode)")
        }
    }
    //执行DataTask
    task.resume()
}
