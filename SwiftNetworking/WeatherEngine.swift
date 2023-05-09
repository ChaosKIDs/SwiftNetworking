//
//  WeatherEngine.swift
//  SwiftNetworking
//
//  Created by Jack Yang on 2023/5/6.
//

import Foundation
////Start of tutorial Part - 1
////https://www.chaoskids.net/2023/05/06/basic-networking-in-swift-part-1/
//func fetchWeatherData() {
//    print("-----API call starts here-----")
//    //API请求地址
//    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=35.18147&lon=136.90641&appid=\(API_KEY)") else {
//        print("Invalid URL")
//        return
//    }
//
//    //建立URLRequest对象，请求方式为GET
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//
//    //建立URLSession dataTask来请求API并获取返回结果
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        //异常返回
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//            return
//        }
//
//        //Http响应异常
//        guard let httpResponse = response as? HTTPURLResponse else {
//            print("Invalid response")
//            return
//        }
//
//        //获得200(OK)响应，处理返回数据
//        if httpResponse.statusCode == 200 {
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    if let weatherData = json as? [String: Any] {
//                        //处理返回的data数据
//                        print("Weather data: \(weatherData)")
//                    }
//                } catch {
//                    print("Error parsing JSON: \(error.localizedDescription)")
//                }
//            }
//        } else {
//            print("API request error with code: \(httpResponse.statusCode)")
//        }
//    }
//    //执行DataTask
//    task.resume()
//}
////End of tutorial Part - 1

//Start of tutorial Part - 2
var API_LAT = "35.18147"//未来将通过CoreLocation获取
var API_LON = "136.90641"//未来将通过CoreLocation获取
var API_UNITS = "metric" //公制单位
var API_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(API_LAT)&lon=\(API_LON)&units=\(API_UNITS)&appid=\(API_KEY)" //合成请求URL

class WeatherEngine {
    //添加completion使方法返回WeatherData对象，或作异常处理
    func fetchWeathData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
        //定义url并处理异常
        guard let url = URL(string: API_URL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        //定义datatask
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //如果出现异常直接返回
            if let error = error {
                completion(.failure(error))
                return
            }
            //定义http响应对象和异常处理
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0)))
                return
            }
            //如果返回状态码200(OK)则开始处理返回数据
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 0)))
                    return
                }
                do {
                    //创建WeatherData对象实例weather，并将解出的字段赋予给weather
                    if let weatherData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let weatherArray = weatherData["weather"] as? [[String: Any]],
                           let mainData = weatherData["main"] as? [String: Any],
                           let weatherMain = weatherArray.first?["main"] as? String,
                           let feelsLike = mainData["feels_like"] as? Double {
                            let weather = WeatherData(weatherMain: weatherMain, feelsLike: feelsLike)
                            completion(.success(weather))
                        } else {
                            completion(.failure(NSError(domain: "Invalid weather data", code: 0)))
                        }
                    } else {
                        completion(.failure(NSError(domain: "Invalid weather data", code: 0)))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "API request with code\(httpResponse.statusCode)", code: httpResponse.statusCode)))
            }
        }
        //执行datatask
        task.resume()
    }
    
    func apiUrlCheck(){
        print(API_URL)
    }
}
//End of tutorial Part - 2
