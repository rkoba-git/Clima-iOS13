//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

//UITextFieldDelegateはprotcol(これでprotocol内に定義されたtextFieldShouldReturn...などの関数が使用可能に)
class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    //    var lat: CLLocationDegrees = 0.0
    //    var lon: CLLocationDegrees = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self //selfは現在のViewControllerを指す
        locationManager.delegate = self //これでCLLocationManager()の中のdelegate変数がこのクラスになった
        locationManager.requestWhenInUseAuthorization() //ユーザーに許可を求めるポップアップを表示
        locationManager.requestLocation() //これで位置情報取得
        
    }
    @IBAction func buttonLocationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    
}

//MARK: - UITextFieldDelegate
extension WeatherViewController:UITextFieldDelegate{
    
    @IBAction func searchedPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    //これらは実際はtextField側で関数呼び出しがされる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { //入力が終わろうとしている時
        if textField.text != "" { //ここでtextFieldを使用することで，呼び出されたtextField個々に対して処理が行われる(searchTextFieldだったらsearchTextFieldだけが処理される)
            return true //終わっていいよ
        }else{
            textField.placeholder = "入力してね"
            return false//終わってはダメ
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.sync {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityNameString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //場所の取得に成功したという通知
        if let location = locations.last{
            locationManager.stopUpdatingHeading()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
