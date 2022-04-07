//
//  ViewController.swift
//  port
//
//  Created by Андрей Orlov on 3/18/22.
//

import UIKit

class ViewController: UIViewController {

    var weather: CurrentWeatherData!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel:
       UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    
    @IBOutlet weak var measureSegment: UISegmentedControl!
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        measureSegment.selectedSegmentIndex = 0
        getCurrentWeather(city:"Moscow")
        
        
        TableView.delegate = self
        TableView.dataSource = self
    }
        
    func getTempString(weather:CurrentWeatherData) -> String{
        switch self.measureSegment.selectedSegmentIndex{
    
            
        case 0:
            let tempInCelsius = Int(weather.main["temp"]!-273)
            let tempString = (tempInCelsius > 0) ? "+ \(tempInCelsius) C " : "\(tempInCelsius) C"
            return tempString
            
        case 1:
            let tempInCelsius = Int(weather.main["temp"]!-273)
            let tempInFahr =   tempInCelsius * 2  + 32
            let tempString = (tempInFahr > 0) ? "+ \(tempInFahr) F " : "\(tempInFahr) F"
            return  tempString
        case 2:
            let tempString = "\(Int(weather.main["temp"]!)) K"
            return tempString
        default: return ""
            
        }
        
    }
        func getCurrentWeather(city:String){
            NetworkManager.shared.getRequest(city: city){
                weather in
                
                
                self.weather = weather
                
                DispatchQueue.main.async {
                    self.cityLabel.text = weather.name
                    
                    
                    self.tempLabel.text = self.getTempString(weather:weather)
                    
                    let dir = getDirection(deg:weather.wind["deg"]!)
                    
                    
                    self.windLabel.text = "\(dir) \(weather.wind["speed"]!) м/с"
                }
                
                
                
            }
            func getDirection(deg:Double)->String{
                switch deg {
                case 0..<45:
                    return  "Cевер"
                case 46..<135:
                    return  "Bосток"
                case 136..<245:
                    return "Юг"
                case 245..<315:
                    return "Запад"
                case 315..<360:
                    return  "Cевер"
                default : return ""
                }
            }
        }
        
        
    

    @IBAction func changeMeasure(_ sender: UISegmentedControl) {
        guard let weather = weather else{
            return
        }
        self.tempLabel.text = getTempString(weather:weather)
    }
    
    @IBAction func requestTap(_ sender: UIButton) {
        
        guard let city = cityTextField.text else{
            return
        }
    
    
    self.getCurrentWeather(city: city)
        
        
        
    
    
    
    }
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        
        
        
        return cell
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    
}
