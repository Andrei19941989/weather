//
//  ForecastModel.swift
//  port
//
//  Created by Андрей Orlov on 3/30/22.
//

import Foundation


class ForecastModel{
    
    var timeStamp: Date
    var dayTemp: Int
    var nightTemp: Int
    var windSpeed: Int
    var windDir:WindDirection
    
    
    
    init(timeStamp:Date,
         dayTemp: Int,
         nightTemp:Int,
         windSpeed:Int,
         windDir:WindDirection){
        
        
        self.timeStamp = timeStamp
        self.dayTemp = dayTemp
        self.nightTemp = nightTemp
        self.windSpeed = windSpeed
        self.windDir = windDir
        
    }
    
}
