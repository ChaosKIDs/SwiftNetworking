//
//  WeatherData.swift
//  SwiftNetworking
//
//  Created by Jack Yang on 2023/5/9.
//

import Foundation

class WeatherData {
    //定义变量
    var weatherMain: String
    var feelsLike: Double
    //初始化Weather对象
    init(weatherMain: String, feelsLike: Double) {
        self.weatherMain = weatherMain
        self.feelsLike = feelsLike
    }
}
