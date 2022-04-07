//
//  CurrentWeatherData.swift
//  port
//
//  Created by Андрей Orlov on 3/23/22.
//

import Foundation


class CurrentWeatherData:Decodable{
    var name = ""
    var main = ["temp":0.0,
                "feelsLike":0.0,
                "pressure":0.0,
                "hummidity":0.0]
    var wind = ["speed":0.0,
                "deg":0.0]
    
    
    
}
