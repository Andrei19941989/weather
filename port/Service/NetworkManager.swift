//
//  NetworkManager.swift
//  port
//
//  Created by Андрей Orlov on 3/21/22.
//

import Foundation


class NetworkManager{
    
 private let apiKey = "9e048a0b15aa80842b20737fa7f801b2"
    static let shared = NetworkManager()
    
    private init(){}
    
    func getRequest(city:String, completion: @escaping(_ weather:CurrentWeatherData) ->()){
        let tunnel = "https://"
        let domain = "api.openweathermap.org"
        let method = "/data/2.5/weather"
        let parameters = "?q=\(city)&appid=\(apiKey)"
        let url = " \(tunnel)\(domain)\(method)\(parameters)"
        let urlString = tunnel + domain + method + parameters
        
        guard let url = URL(string:urlString) else{
            print("URL invalid")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { data,response, error in
            
            guard let response = response, let data = data
               else {
                print ("Ответа от сервера нет, данные не получены")
                   if let error = error{ (error.localizedDescription)
                       
                   }
                   
                return
            }
            print("Response:\(response)")
            print("Data:\(data)")
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let weather=try decoder.decode(CurrentWeatherData.self, from:data)
                
                completion(weather)
                
                print(weather.name)
                print(weather.main)
                print(weather.wind)
            }
            catch{
                print(error.localizedDescription)
            }
            

        
        }.resume()
        
        
        
        
    
    }
    
    
}
